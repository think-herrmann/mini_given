require 'mini_given'
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'
require 'byebug'

class MiniTest::Spec
  extend MiniGiven::Spec
end
