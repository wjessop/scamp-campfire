class Scamp
  module Campfire
    module Users
      def username_for_user_id(user_id)
        user_data(user_id)['name'] rescue user_id
      end

      private

      def user_data(user_id)
        ensure_user_data_is_cached(user_id)
        puts user_cache.inspect
        user_cache[user_id]
      end

      def ensure_user_data_is_cached(user_id)
        user_cache[user_id] || begin
          puts "Fetching user data for #{user_id}"
          fetch_and_cache_user_data(user_id)
        end
      end

      def fetch_and_cache_user_data(user_id)
        connection.fetch_user_data_for_user_id(user_id) do |user_data|
          puts "Setting cache to #{user_data.inspect}"
          cache_data_for_user(user_id, user_data)
        end
      end

      def cache_data_for_user(user_id, user_data_hash)
        user_cache[user_id] = user_data_hash
      end

      def user_cache
        @user_cache ||= {}
      end
    end
  end
end