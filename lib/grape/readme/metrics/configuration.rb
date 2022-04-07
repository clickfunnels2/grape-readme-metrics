module Grape
  module ReadMe
    module Metrics
      class Configuration
        attr_accessor :sdk_options, :id, :label, :email

        def initialize
          @sdk_options = {
            api_key: "INSERT_YOUR_README_API_KEY_HERE",
            development: false,
            reject_params: ["not_included", "dont_send"],
            buffer_length: 5
          }

          @id = "guest"
          @label = "Guest User"
          @email = "guest@example.com"
        end
      end
    end
  end
end
