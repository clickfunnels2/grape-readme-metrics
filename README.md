# Grape::ReadMe::Metrics

Grape middleware to log ReadMe metrics for Grape API endpoints. The spiritual equivalent of [ReadMe::Metrics](https://github.com/readmeio/metrics-sdks/tree/main/packages/ruby) but for Grape APIs.

## Getting Started

Read up on ReadMe::Metrics's [usage](https://github.com/readmeio/metrics-sdks/tree/main/packages/ruby#usage).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "grape-readme-metrics"
```

Then execute:

    $ bundle install

## Usage

Mount the middleware in your API:

```ruby
class MyApi < Grape::API
  use Grape::ReadMe::Metrics::Logging
end
```

Define settings in an initializer (defaults below):

```ruby
# config/initializers/grape_readme_metrics.rb

Grape::ReadMe::Metrics.configure do |config|
  config.sdk_options.api_key = "INSERT_YOUR_README_API_KEY_HERE"
  config.sdk_options.development = false
  config.sdk_options.reject_params = ["not_included", "dont_send"]
  config.sdk_options.buffer_length = 5

  # these defaults can be overridden within Grape endpoints
  config.id = "guest"
  config.label = "Guest User"
  config.email = "guest@example.com"
end
```

Then enable for your Grape endpoints using the `log_readme_metrics` DSL:

```ruby
class MyApi < Grape::API
  use Grape::ReadMe::Metrics::Logging

  resources :contacts do
    log_readme_metrics
    get do
      Contact.all
    end
  end
end
```

That's it!

## More Information

Refer to [ReadMe::Metrics](https://github.com/readmeio/metrics-sdks/tree/main/packages/ruby) for information on ReadMe metrics.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

