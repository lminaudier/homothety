# Homothety

_Homothety_ is a gem to perform HTML transforms. The goal is to allow decoupling
frontend and backend code by using templates for what they are, simple HTML
files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'homothety'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install homothety

## Usage

Given that you have some piece of data that you need to render to a user in
HTML.

```ruby
{
  name: "Sponge Bob",
  age: 42
}
```

Given that your frontend expert implemented a nice HTML prototype

```html
<div class="user">
  <span class="name">John Doe</span>
  <span class="age">18</span>
</div>
```

_Homothety_ allows you to transform the above HTML to the desired output below

```html
<div class="user">
  <span class="name">Sponge Bob</span>
  <span class="age">42</span>
</div>
```

That means that your designer/integrator don't need to learn any templating
language such as ERB or HAML. He can use whatever tool he likes to build up some
HTML that you use directly to render real data.

Here is how it looks like in _Homothety_.

First you declare a couple of HTML transforms

```ruby
Homothety::Registry.register :name, selector: ".user .name" do |nodes, data|
  nodes.first.inner_text = data[:name]
end

Homothety::Registry.register :age, selector: ".user .age" do |nodes, data|
  nodes.first.inner_text = data[:age].to_s
end
```

A transform is a block of code that is executed in a HTML scope (defined via CSS
Selectors).

It is basically, find HTML nodes via the CSS Selector and execute the block in
this context.

The code block can update HTML nodes. Here we are just replacing the text of the
first matched node.

Once all your transforms are defined, you apply them to the original HTML to
transform it the way you want :

```ruby
data = {
  name: "Sponge Bob",
  age: 42
}

Homothety.apply(
  template: "path/to/user_name_and_age.html",
  transforms: [:name, :age],
  data: data
)
```

`Homothety.apply` transform the input HTML according the defined transforms in
order.

You can also apply transforms one by one.

Given you registered the following transform

```ruby
Homothety::Registry.register :age, selector: ".user .age" do |nodes, data|
  nodes.first.text = data[:age].to_s
end
```

You can transform some input regarding this single transform with

```ruby
data = {
  age: 42
}
content = File.read("path/to/html")
Homothety.new(template: content).apply(:age, data)
```

## Development

### Setup

After checking out the repo, run `bin/setup` to install dependencies.

### Tests

Use `rspec` to run tests.

Mutant is also setup. To run everything (Rspec and mutant) use `bin/test`

### Console

Run `bin/console` for an interactive prompt that will allow you to experiment.

### Release

To install this gem onto your local machine, run `bundle exec rake install`.

## Release

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Inspiration

The Clojure templating library [enlive](https://github.com/cgrand/enlive) is
what inspired me for this gem.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/homothety/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
