require 'em-campfire'
require 'scamp/adapter'

class Scamp
  module Campfire
    class Adapter < Scamp::Adapter
      include Scamp::Campfire::Users

      def connect!
        connection.on_message do |message|
          if matches_required_format?(message[:body])
            msg = Scamp::Campfire::Message.new self, :body => strip_prefix(message[:body]),
                                                     :room_id => message[:room_id],
                                                     :user_id => message[:user_id],
                                                     :type => message[:type]

            channel = Scamp::Campfire::Channel.new self, msg
            push [channel, msg]
          end
        end

        @opts[:rooms].each do |room|
          connection.join(room) do |room_id|
            pre_populate_user_cache_from_room_data(room_id)
            connection.stream(room_id)
          end
        end
      end

      def say(message, room_id)
        connection.say(room_id, message)
      end

      def paste(message, room_id)
        connection.paste(room_id, message)
      end

      def play(sound, room_id)
        connection.play(room_id, sound)
      end

      def required_prefix
        @opts[:required_prefix]
      end

      def ignore_self?
        @opts[:ignore_self] || false
      end

      private

      def pre_populate_user_cache_from_room_data(room_id)
        connection.room_data_from_room_id(room_id) do |room_data|
          room_data['users'].each do |user_data|
            cache_data_for_user(user_data['id'], user_data)
          end
        end
      end

      def connection
        @connection ||= EM::Campfire.new(
          :subdomain => @opts[:subdomain],
          :api_key => @opts[:api_key], 
          :verbose => @opts[:verbose],
          :ignore_self => @opts[:ignore_self],
          :logger => @opts[:logger]
        )
      end
    end
  end
end
