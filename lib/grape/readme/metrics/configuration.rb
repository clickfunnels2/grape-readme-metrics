module Grape
  module ReadMe
    module Metrics
      class Configuration
        attr_accessor :sdk_api_key, :sdk_development, :user_id, :user_label, :user_email

        def initialize
          @sdk_api_key = "INSERT_YOUR_README_API_KEY_HERE"
          @sdk_development = false

          @user_id = "guest"
          @user_label = "Guest User"
          @user_email = "guest@example.com"
        end
      end
    end
  end
end
