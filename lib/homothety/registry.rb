module Homothety
  class Registry
    @@transforms = {}

    def self.register(name, selector:, &block)
      @@transforms[name] = Transform.new(selector: selector, block: block)
    end

    class UnknownTransform < RuntimeError
      attr_reader :transform_name

      def initialize(transforms, transform_name)
        @transforms = transforms
        @transform_name = transform_name
      end

      def message
        "Undefined transform '#{transform_name}'\nRegister transforms : #{transforms}"
      end

      def transforms
        @transforms.keys
      end
    end

    def self.get(name)
      @@transforms.fetch(name) do
        raise UnknownTransform.new(@@transforms, name)
      end
    end
  end
end
