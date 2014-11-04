module Givens
  def foo_has_a_bar
    @foo = {:bar => true}
  end

  def bar_has_a_foo
    @bar = {:foo => true}
  end

  def something_has_a_bar(something)
    something[:bar] = true
  end

  def bar_has_a_something(something)
    @bar = {something:something}
  end
end
