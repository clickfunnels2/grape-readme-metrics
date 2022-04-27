require "os"

module Grape
  module ReadMe
    module Metrics
      SDK_NAME = "Grape ReadMe Metrics SDK"
      VERSION = "0.0.5"
      PLATFORM = OS.windows? ? "Windows" : OS.mac? ? "macOS" : OS.linux? ? "Linux" : "Unknown"
    end
  end
end
