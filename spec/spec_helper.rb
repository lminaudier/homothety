$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'homothety'

require_relative "support/core_ext"
require_relative "support/fixture"
require_relative "support/matchers"

RSpec.configure do |c|
  c.include Fixture
end
