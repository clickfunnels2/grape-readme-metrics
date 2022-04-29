require "grape/readme/metrics"
require "os"

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
			  comment: comment
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

		  def comment
			platform = OS.windows? ? "Windows" : OS.mac? ? "macOS" : OS.linux? ? "Linux" : "Unknown"
			ruby_version = "ruby #{RUBY_VERSION}"

			"#{platform} / #{ruby_version}"
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
			  url: @request.absolute_path,
			  httpVersion: @request.httpVersion,
			  headers: @request.headers(true),
			  queryString: @request.queryString(true),
			  cookies: @request.cookies(true),
			  postData: post_data,
			  headersSize: -1,
			  bodySize: -1,
			  comment: @request.route.description
		  	}.compact
		  end

		  def response_as_json
			{
			  status: @response.status,
			  statusText: Rack::Utils::HTTP_STATUS_CODES[@response.status],
			  httpVersion: @request.httpVersion,
			  headers: @response.headers.map { |n,v| { name: n, value: v } },
			  cookies: @request.cookies(true),
			  content: {
				mimeType: @response.content_type,
				size: @request.body.bytesize,
				text: JSON.parse(@request.body)
			  },
			  redirectURL: @response.location.to_s,
			  headersSize: -1,
			  bodySize: @request.body.bytesize
		  	}.compact
		  end

		  def post_data
			nil
		  end
	  	end
	  end
  	end
  end
end
