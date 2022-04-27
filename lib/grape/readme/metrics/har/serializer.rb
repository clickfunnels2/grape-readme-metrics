require "grape/readme/metrics/version"

module Grape
  module ReadMe
  	module Metrics
	  module Har
	  	class Serializer
		  HAR_VERSION = "1.2"

		  def initialize(request, response, start_time, duration)
			@request = request
			@response = response
			@start_time = start_time
			@duration = duration
		  end

		  def to_json
			{
			  log: {
				version: HAR_VERSION,
				creator: creator,
				entries: entries
			  }
		  	}.to_json
		  end

		  private

		  def creator
			{
			  name: ::Grape::ReadMe::Metrics::SDK_NAME,
			  version: ::Grape::ReadMe::Metrics::VERSION,
			  comment: "#{::Grape::ReadMe::Metrics::PLATFORM}/#{RUBY_VERSION}"
		  	}
		  end

		  def entries
			[
			  {
				cache: {},
				timings: timings,
				request: request_as_json,
				response: response_as_json,
				startedDateTime: @start_time.iso8601,
				time: @duration
			  }
		  	]
		  end

		  def timings
			{
			  send: 0,
			  receive: 0,
			  wait: @duration
		  	}
		  end

		  def request_as_json
			{
			  method: @request.method,
			  url: @request.path,
			  httpVersion: @request.httpVersion,
			  headers: @request.headers(true),
			  queryString: @request.queryString(true),
			  headersSize: -1
		  	}
		  end

		  def response_as_json
			{
			  status: @response.status,
			  statusText: Rack::Utils::HTTP_STATUS_CODES[@response.status],
			  httpVersion: @request.httpVersion,
			  headers: @response.headers.map { |k, v| { name: k, value: v } }
			}
		  end
	  	end
	  end
  	end
  end
end
