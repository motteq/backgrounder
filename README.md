# Backgrounder

Create background jobs using Redis with ease.

## Installation

Add this line to your application's Gemfile:

    gem 'backgrounder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install backgrounder

## Usage

```ruby
class Dummy < ActiveRecord::Base
  include Backgrounder::Handler

  @queue = :high

  def self.foo
    # ...
  end

  def bar
    # ...
  end
end

dummy = Dummy.create
Backgrounder::Placer.new(Dummy, :foo).place
Backgrounder::Placer.new(dummy, :bar, queue: :processing).place

class Puppet
  include Backgrounder::Handler

  def initialize args={}
    # ...
  end

  def foo
    # ...
  end
end

Backgrounder::Placer.new(Puppet, :foo, args: {
  init_args: {content: 'foo', phone: 'bar'}
}, queue: :critical).place  # Puppet.new('content' => 'foo', 'phone' => 'bar'}).foo
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
