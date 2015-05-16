require "pathname"

module Fixture
  def fixture(path)
    File.read(fixture_path(path))
  end

  def fixture_path(path)
    Pathname.new(File.expand_path("../../fixtures", __FILE__)).join(path)
  end
end
