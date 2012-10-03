# Guard::Play

A [guard](https://github.com/guard/guard) plugin for automatically running tests with Play Framework.

## Installation

Add this line to your application's Gemfile:

    gem 'guard-play'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install guard-play

## Usage

Then run:

    $ guard init play

This will setup your `Guardfile` with the basics you need to watch tests. To run guard, simply run:

    $ guard

Once guard is running, anytime one of the 'watched' files is changed, the specified test will be run.

The next steps are to add additional files to watch, with accompanied tests to run. For example:

```ruby
guard 'play' do
  watch(/test\/([^\/]+)\.java$/) {|m| "#{m[1]}"}
  watch(/test\/(.+)\/(.+)\.java/) {|m| "#{m[1]}.#{m[2]}"} # watch tests in sub-packages
  watch("app/controllers/PostsController.java") { "PostsTest" }
end
```

I found it helpful to add a few helper methods for watching models and controllers:

```ruby
guard 'play' do
  def model(name, test)
    self.watch("app/models/#{name}") { test }
  end
  def controller(name, test)
    self.watch("app/controllers/#{name}") {test}
  end
  model "User.java", "UserTest" # => watch("app/models/User.java") { "UserTest" }
  controller "Auth.java", "AuthTest"
end
```

Hopefully you find it helpful!

##Todo

* support for selenium tests
