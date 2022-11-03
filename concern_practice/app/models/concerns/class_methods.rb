module Foo
  extend ActiveSupport::Concern

  def instance_method_injected_by_foo
    puts "Instance method defined in Foo"
  end

  class_methods do
    def class_method_injected_by_foo
      puts "Class method defined in Foo"
    end
  end
end