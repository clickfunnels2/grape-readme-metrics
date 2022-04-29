require "uuid"

module Grape
  module ReadMe
  	module Metrics
	  class Payload
		attr_reader :to_json

		def initialize(har, user_info, clientIPAddress:, development:)
		  @to_json = [{
			logId: UUID.new.generate,
			group: user_info,
			clientIPAddress: clientIPAddress || "1.1.1.1",
			development: development || false,
			request: JSON.parse(har.to_json)
		  }].to_json
	  	end
	  end
  	end
  end
end
