module Homothety
  class Transform
    attr_reader :selector, :block

    def initialize(selector:, block:)
      @selector = selector
      @block = block
    end
  end
end
