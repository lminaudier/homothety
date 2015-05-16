require 'spec_helper'

describe "Acceptance" do
  using CoreExt

  subject(:output) do
    Homothety.apply(
      template: fixture_path("basic.html"),
      transforms: [:name, :age],
      data: data
    )
  end

  before do
    Homothety::Registry.register :name, selector: ".user .name" do |nodes, data|
      nodes.first.inner_text = data[:name]
    end

    Homothety::Registry.register :age, selector: ".user .age" do |nodes, data|
      nodes.first.inner_text = data[:age].to_s
    end
  end

  let(:data) do
    {
      name: "The Librarian",
      age: 18
    }
  end

  it "transforms a simple HTML template" do
    expect(output).to render_html <<-EOS
      <div class="user">
        <span class="name">The Librarian</span>
        <span class="age">18</span>
      </div>
    EOS
  end
end
