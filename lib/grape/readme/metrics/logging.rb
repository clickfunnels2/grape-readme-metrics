require "grape/readme/metrics/request"

module Grape
  module ReadMe
    module Metrics
      class Logging < Grape::Middleware::Base

        def after
          request = ::Grape::ReadMe::Metrics::Request.new(env)
          return unless request.log_metrics?

          # TODO: send API logs to ReadMe

          header("x-documentation-url", nil)

          @app_response
        end
      end
    end
  end
end
