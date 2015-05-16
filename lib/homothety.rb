require "oga"

module Homothety
  def new(template:)
    Apply.new(template: template)
  end
  module_function :new

  def apply(template:, transforms: [], data: {})
    fixture = File.read(template)
    transforms.inject(fixture) do |content, transform_name|
      content = Homothety.new(template: content).apply(transform_name, data)
    end
  end
  module_function :apply
end

require "Homothety/apply"
require "Homothety/registry"
require "Homothety/transform"
require "homothety/version"
