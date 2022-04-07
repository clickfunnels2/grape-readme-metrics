require "active_model"

module Grape
  module ReadMe
    module Metrics
      class Options
        include ActiveModel::Model
        include ActiveModel::Validations

        attr_accessor :sdk_api_key, :sdk_development, :sdk_reject_params, :sdk_buffer_length
        attr_accessor :user_id, :user_label, :user_email

        validates_presence_of :sdk_api_key
        validates :sdk_buffer_length, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

        validates_presence_of :user_id
        validates_presence_of :user_label
        validates_presence_of :user_email
      end
    end
  end
end
