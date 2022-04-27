require "grape/readme/metrics/options"

module Grape
  module ReadMe
    module Metrics
      class Request
        attr_reader :env, :context, :route, :options

        def initialize(env, context)
          @env = env
          @context = context
          @route = context.routes.first
          @options = Options.new(context.route_setting(:log_readme_metrics))
        end

        def method
          route.request_method
        end

        def path
          "#{env["REQUEST_URI"].slice(/^[^?]+/)}"
        end

        def httpVersion
          env["HTTP_VERSION"]
        end

        def queryString(as_har_array = false)
          return env["QUERY_STRING"].split("&").map { |p| { name: p.split("=")[0], value: p.split("=")[1] } } if as_har_array
          env["QUERY_STRING"]
        end

        def params
          context.params
        end

        def headers(as_har_array = false)
          return context.headers.map { |k, v| { name: k, value: v } } if as_har_array
          context.headers
        end

        def method_missing(method_name, *args, &block)
          context.public_send(method_name, *args, &block)
        end

        def respond_to_missing?(method_name, include_private = false)
          context.respond_to?(method_name)
        end

        def client_identifier
          options.user_id || env["HTTP_X_REAL_IP"] || env["REMOTE_ADDR"]
        end

        def log_metrics?
          return false unless context.route_setting(:log_readme_metrics).present?
          return true if options.valid?

          fail ArgumentError.new(options.errors.full_messages)
        end
      end
    end
  end
end
