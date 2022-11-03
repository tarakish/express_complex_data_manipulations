class Cancelable
  extend ActiveSupport::Concern

  included do
    has_one :cancellation, class_name: "#{name}Cancellation"
  end
end