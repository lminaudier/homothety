module Homothety
  class Apply
    attr_reader :template

    def initialize(template:)
      @template = template
    end

    def apply(transform_name, data)
      transform = Registry.get(transform_name)
      document = Oga.parse_html(template)
      node_set = document.css(transform.selector)
      transform.block.call(node_set, data)
      document.css(transform.selector)
      document.to_xml
    end
  end
end
