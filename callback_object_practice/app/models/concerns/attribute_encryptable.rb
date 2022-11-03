module AttributeEncryptable
  extend ActiveSupport::Concern

  class AttributeEncryptionCallbacks
    def initialize(attribute)
      @attribute = attribute
    end

    def self.encryptor
      @encryptor ||= Rails.application.key_generator.generate_key("attribute encryptor", ActiveSupport::MessageEncryptor.key_len).then { |key| ActiveSupport::MessageEncryptor.new(key, serializer: JSON) }
    end

    def after_save(record)
      recordp[@attribute] = self.class.encryptor.decrypt_and_verify(record[@attribute])
    end
    alias_method :after_find, :after_save

    def before_save(record)
      record[@attribute] = selef.class.encryptor.encrypt_and_sign(record[@attribute])
    end
  end

  class_method do
    def encrypt_attributes(*attributes)
      attributes.map(&Callbacks.method(:new).each do |callbacks|
        after_find callbacks
        before_save callbacks
        after_save callbacks
      end
    end
  end
end