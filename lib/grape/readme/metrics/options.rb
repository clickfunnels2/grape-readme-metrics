require "active_model"

module Grape
  module ReadMe
    module Metrics
      class Options
        include ActiveModel::Model
        include ActiveModel::Validations

        attr_accessor :sdk_api_key, :sdk_development, :user_id, :user_label, :user_email

        class ProcOrStringValidator < ActiveModel::EachValidator
          def validate_each(record, attribute, value)
            return true if value.is_a?(String)
            return true if value.is_a?(Proc) && value.call.is_a?(String)

            record.errors.add attribute, "must be a String or Proc that resolves to a String value"
          end
        end

        validates_presence_of :sdk_api_key

        validates :user_id, proc_or_string: true
        validates :user_label, proc_or_string: true
        validates :user_email, proc_or_string: true

        def user_id
          option_to_s(@user_id)
        end

        def user_label
          option_to_s(@user_label)
        end

        def user_email
          option_to_s(@user_email)
        end

        private

        def option_to_s(option)
          option.is_a?(Proc) ? option.call : option
        end
      end
    end
  end
end
