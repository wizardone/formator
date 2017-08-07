# Formator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'forminator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install forminator

## Usage
First you need to configure the wizard so it knows the object that you
interact with (usually a used model) and the amount of steps that this
object needs to undertake. If you like to persist the model you can
supply a callable object that takes care of the persistence. Whether you
want to persist after each step or after the final one is up to you.

```ruby
Forminator.configure do |config|
  config.klass = :user
  config.persist = -> (user) { user.save }
  config.steps = [FirstStep, MiddleStep, LastStep]
end
```
To build a form wizard step you need to subclass the `Forminator::Step`
class

```ruby
class FirstStep < Forminator::Step
  validations do
    required(:email) { filled? }
    required(:password) { filled? }
  end

  # By default this returns false, so if you want to persist the object
  # after each step you need to overwrite the method
  def persist?
    true
  end

  # This method will do the actual persisting. If you want to persist
  #  after each step without any changes just call the parent method
  def persist
    super
  end
end
```
Then you can do:
```ruby
FirstStep.(some_params)
=> [:valid, some_params]
# Internally this does:
first_step = FirstStep.new(some_params)
first_step.validate
return [first_step.ok?, some_params]
```

`Forminator` uses `Hanami::Validations` which in it's own term uses
`Dry::Validation` :heart
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wizardone/forminator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

