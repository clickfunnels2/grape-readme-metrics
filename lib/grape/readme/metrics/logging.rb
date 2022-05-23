require "grape/readme/metrics/har/serializer"
require "grape/readme/metrics/request"
require "grape/readme/metrics/payload"
require "httparty"

module Grape
  module ReadMe
    module Metrics
      class Logging < Grape::Middleware::Base
        README_METRICS_API_ENDPOINT = "https://metrics.readme.io/v1/request"

        def before
          @start_time = Time.now
        end

        def after
          # we don't want to spam ReadMe with logs from local tests and CI runs
          return if Rails.env.test?

          # we can't log an API response that doesn't exist
          return unless response.present?

          @duration = ((Time.now - @start_time) * 1000).to_i

          request = Request.new(env, context)
          return unless request.log_metrics?

          # creates a payload that will please the ReadMe overlords
          payload = Payload.new(
            Har::Serializer.new(request, response, @start_time, @duration),
            {
              id: request.options.user_id,
              label: request.options.user_label,
              email: request.options.user_email
            },
            clientIPAddress: env["HTTP_X_REAL_IP"] || env["REMOTE_ADDR"],
            development: request.options.sdk_development
          )

          # sends an API log to ReadMe
          Thread.new do
            begin
              HTTParty.post(
                README_METRICS_API_ENDPOINT,
                basic_auth: {
                  username: request.options.sdk_api_key,
                  password: ""
                },
                headers: {
                  "Content-Type" => "application/json"
                },
                body: payload.to_json
              )
            rescue StandardError
              # nothing to do here
            end
          end

          @app_response
        end
      end
    end
  end
end
