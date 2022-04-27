module Grape
  module ReadMe
    module Metrics
      module Extension
        def log_readme_metrics
          route_setting(:log_readme_metrics, {
            sdk_api_key:     ::Grape::ReadMe::Metrics.config.sdk_api_key,
            sdk_development: ::Grape::ReadMe::Metrics.config.sdk_development,
            user_id:         ::Grape::ReadMe::Metrics.config.user_id,
            user_label:      ::Grape::ReadMe::Metrics.config.user_label,
            user_email:      ::Grape::ReadMe::Metrics.config.user_email
          })
        end

        # Grape::API::Instance is defined in Grape >= 1.2.0
        grape_api = defined?(::Grape::API::Instance) ? ::Grape::API::Instance : ::Grape::API
        grape_api.extend self
      end
    end
  end
end
