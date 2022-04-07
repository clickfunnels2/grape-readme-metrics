require "grape/readme/metrics/configuration"

module Grape
  module ReadMe
    module Metrics
      module Configurable
        def config
          @config ||= ::Grape::ReadMe::Metrics::Configuration.new
        end

        def configure
          yield config if block_given?
        end
      end
    end
  end
end
