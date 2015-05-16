require 'rspec/expectations'

RSpec::Matchers.define :render_html do |raw_expected|
  using CoreExt

  define_method :expected do
    raw_expected.unindent
  end

  match do |actual|
    actual.unindent == expected
  end

  diffable
end
