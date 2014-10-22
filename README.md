# MiniGiven

A gem that extends minitest with a few new methods to make it easy to share setup code
between spec tests.

It allows you to take common setup scenarios and extract them into modules that
can be used across multiple tests. It also offers some features to allow for
you to chain together multiple scenarios and use the output of one as parameters
into the next.

All of this is wrapped up in a lightweight bdd style syntax

## Installation

Add this line to your application's Gemfile:

    gem 'mini_given'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mini_given

## Usage

### Basic usage
Let's say you have two separate tests, both which have to setup a foo with a bar

    describe Foo do
      describe "when we have a foo with a bar"
        before do
          @foo = {bar: true}
        end

        it "we can get the bar" do
          @foo[:bar].must_equal true
        end
      end
    end

    describe "Foo2" do
      describe "when we have a foo with a bar in a mess" do
        before do
          @foo = {bar:true}
          @mess = {stuff: @foo}
        end

        it "the mess's foo has a bar" do
          @mess[:stuff][:bar].must_equal true
        end
      end
    end

MiniGiven let's you pull the common code into method in a module,
and then call that method when you'd like

    module FooGivens
      def a_foo_with_a_bar
        @foo = {bar:true}
      end
    end

    describe Foo do
      load_givens FooGivens
      describe "when we have a foo with a bar"
        given :a_foo_with_a_bar

        it "we can get the bar" do
          @foo[:bar].must_equal true
        end
      end
    end

    describe "Foo2" do
      load_givens FooGivens
      describe "when we have a foo with a bar in a mess" do
        given :a_foo_with_a_bar
        before do
          @mess = {stuff: @foo}
        end

        it "the mess's foo has a bar" do
          @mess[:stuff][:bar].must_equal true
        end
      end
    end

Let's break that down. First in the test you make a call to load_givens

    load_givens FooGivens

This pulls in the module with the common setup code you defined. You can create different modules
for different kinds of setup scenarios and only load the ones you want into a given spec

Then second you call

    given :a_foo_with_a_bar

This will tell minitest that before running your test, minitest should call the method
a_foo_with_a_bar, which was defined in your module. It's kind of like calling

    before do
      #...setup code
    end

but it allows that setup code to come from the method defined in your module

### Parameters
The methods called with given can take parameters, so something like this

    module FooGivens
      def something_with_a_bar(something)
        something[:bar] = true
      end
    end

When your given method is being run, the value of the something parameter can be set one of two ways.

First, MiniGiven can just assume that there will be an instance variable named @something and use that value.
This is what happens by default if you just call

    given :a_something_with_a_bar

Second, you can map the parameter to a different instance variable using this syntax

    given :a_something_with_a_bar, :something => :foo

In this situation, the value of the something parameter will be set to whatever value is
stored in the @foo instance variable

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mini_given/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
