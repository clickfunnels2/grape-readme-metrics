require "grape"
require "grape/readme/metrics/version"
require "grape/readme/metrics/configurable"
require "grape/readme/metrics/extension"
require "grape/readme/metrics/exceptions"
require "grape/readme/metrics/log"

module Grape
  module ReadMe
    module Metrics
      extend Configurable
    end
  end
end
