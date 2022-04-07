require "grape/readme/metrics/options"

module Grape
  module ReadMe
    module Metrics
      class Request
        attr_reader :env, :context, :request, :metrics_options

        def initialize(env)
          @env             = env
          @context         = env["api.endpoint"]
          @request         = @context.routes.first
          @metrics_options = ::Grape::ReadMe::Metrics::Options.new(@context.route_setting(:log_readme_metrics))
        end

        def method
          request.request_method
        end

        def path
          request.path
        end

        def params
          request.params
        end

        def method_missing(method_name, *args, &block)
          context.public_send(method_name, *args, &block)
        end

        def respond_to_missing?(method_name, include_private = false)
          context.respond_to?(method_name)
        end

        def client_identifier
          metrics_options.user_id || env["HTTP_X_REAL_IP"] || env["REMOTE_ADDR"]
        end

        def log_metrics?
          return false unless context.route_setting(:log_readme_metrics).present?
          return true if metrics_options.valid?

          fail ArgumentError.new(metrics_options.errors.full_messages)
        end
      end
    end
  end
end
