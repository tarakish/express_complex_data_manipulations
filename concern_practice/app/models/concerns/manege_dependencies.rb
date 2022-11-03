module Foo
  extend ActiveSupport::Concern

  class_methods do
    def class_method_injected_by_foo
      puts "Class method defined in Foo"
    end
  end

  def instance_method_injected_by_foo
    puts "Instance method defined in Foo"
  end
end

module Bar
  extend ActiveSupport::Concern
  include Foo

  class_methods do
    def class_method_injected_by_bar
      puts "Class method defined in Bar"
      class_method_injected_by_foo
    end
  end

  def instance_method_injected_by_bar
    puts "Instance method defined in Bar"
    instance_method_injected_by_foo
  end
end

class Baz
  include Bar
end