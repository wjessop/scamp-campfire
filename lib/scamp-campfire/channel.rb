class Scamp
  module Campfire
    class Channel
      attr_reader :adapter, :message

      def initialize adapter, msg
        @adapter = adapter
        @message = msg
      end

      def say msg
        adapter.say(message.room_id, msg)
      end

      def reply msg
        adapter.say(message.room_id, "#{message.user_id}: #{msg}")
      end

      def paste text
        adapter.paste(message.room_id, text)
      end

      def play sound
        adapter.play(message.room_id, sound.to_s)
      end
    end
  end
end
