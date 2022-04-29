require "grape"
require "grape/readme/metrics/configurable"
require "grape/readme/metrics/exceptions"
require "grape/readme/metrics/extension"
require "grape/readme/metrics/logging"
require "grape/readme/metrics/version"

module Grape
  module ReadMe
    module Metrics
      extend Configurable
    end
  end
end
