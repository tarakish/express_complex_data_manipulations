class User < ApplicationRecord
  validates :phone_number, format: { with: /\A0\d{9,10}\z/ }

  AttributeEncryptionCallbacks.new(:phone_number).tap do |callback|
    after_find callbacks
    before_save callbacks
    after_save callbacks
  end
end