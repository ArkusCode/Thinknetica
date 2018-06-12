module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :checks

    def validate(name, type, option = nil)
      @checks ||= []
      @checks.push(name: name, type: type, option: option)
    end
  end

  module InstanceMethods
    def validate!
      self.class.checks.each do |val|
        send(val[:type], instance_variable_get("@#{val[:name]}".to_sym), val[:option])
      end
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def presence(value, _options)
      raise 'Значение не может быть пустым' if value.empty? || value.nil?
    end

    def format(value, options)
      raise 'Неверный формат' if value !~ options
    end

    def type(value, options)
      raise 'Несоответствие класса' if value.class == options
    end
  end
end
