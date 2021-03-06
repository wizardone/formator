# Forminator
[![Build Status](https://travis-ci.org/wizardone/forminator.svg?branch=master)](https://travis-ci.org/wizardone/forminator)
[![codecov](https://codecov.io/gh/wizardone/forminator/branch/master/graph/badge.svg)](https://codecov.io/gh/wizardone/forminator)

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
interact with (usually a used model). If you like to persist the model you can
supply a callable object that takes care of the persistence. Whether you
want to persist after each step or after the final one is up to you.

```ruby
Forminator.configure do |config|
  config.klass = :user
  config.persist = -> (user) { user.save }
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
end
```
Then you can do:
```ruby
user = User.new
some_params = { email: 'test@test.com', password: 'ineedtocryptmypassword' }
FirstStep.(user, some_params)
=> [{ valid: true }, some_params]
```
Each step always returns an array of 2 elements: a hash with the
validity and the initially passed params. This allows for easy chaining
of events.


If you want to call a custom persistence logic for a certain step you
can pass an optionable callable object like so:

```ruby
class CustomPersistenceLogic
  def call(user)
    # persistence logic goes here
  end
end
user = User.new
FirstStep.(user, some_params, persist: CustomPersistenceLogic.new)
```
The callable object will receive the original object that you interact
with.

Want to build a whole flow of steps? Just use the `Forminator::Flow`
class
```ruby
steps = [FirstStep, SecondStep, LastStep]
flow = Forminator::Flow.new(steps: steps)
flow.current_step
=> FirstStep
flow.next_step
=> SecondStep
```
You can also add steps on the way with:
```ruby
flow.add(step: IntermediateStep)
```
Keep in mind that you can only add steps that inherit from
`Forminator::Step`.
You can also remove steps:
```ruby
flow.remove(step: LastStep)
=> LastStep
```
Calling `remove` will return the removed step.

`Forminator` uses `Hanami::Validations` which in it's own term uses
`Dry::Validation` :heart. You can [refer](https://github.com/hanami/validations) them for a detailed DSL about
validations.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wizardone/forminator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

