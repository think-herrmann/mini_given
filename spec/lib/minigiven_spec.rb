require 'spec_helper'
require 'givens'

describe MiniGiven do
  describe "when we load givens" do
    load_givens Givens
    describe "and then call one of the givens" do
      given :foo_has_a_bar

      it "has called the given" do
        @foo[:bar].must_equal true
      end
    end

    describe "and then call two givens" do
      given :foo_has_a_bar
      given :bar_has_a_foo

      it "has called both givens" do
        @foo[:bar].must_equal true
        @bar[:foo].must_equal true
      end
    end

    describe "and then call a given with a overloaded parameter" do
      given :bar_has_a_foo
      given :something_has_a_bar, :something => :bar

      it "has called both givens" do
        @bar[:foo].must_equal true
        @bar[:bar].must_equal true
      end
    end

    describe "and then call a given and a normal before block" do
      given :foo_has_a_bar
      before do
        @test = {:bar => true}
      end

      it "has called both the given and the before" do
        @test[:bar].must_equal true
        @foo[:bar].must_equal true
      end
    end

    describe "and then call a given with an implied parameter" do
      before do
        @something = {:foo => true}
      end
      given :something_has_a_bar

      it "used the instance variable as a parameter for the given" do
        @something[:bar].must_equal true
      end
    end

    describe "and then call a given with an explicit parameter" do
      given :bar_has_a_something, :something => "test"

      it "uses the explicit parameter as the parameter for the given" do
        @bar[:something].must_equal "test"
      end
    end

  end
end
