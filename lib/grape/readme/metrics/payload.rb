require "uuid"

module Grape
  module ReadMe
  	module Metrics
	  class Payload
	  	def initialize(har, user_info, clientIPAddress:, development:)
		  @har = har
		  @user_info = user_info

		  @clientIPAddress = clientIPAddress || "1.1.1.1"
		  @development = development || false

		  @uuid = UUID.new
	  	end

		def to_json
		  [{
			logId: @uuid.generate,
			group: @user_info,
			clientIPAddress: @clientIPAddress,
			development: @development,
			request: JSON.parse(@har.to_json)
		  }].to_json
	  	end
	  end
  	end
  end
end
