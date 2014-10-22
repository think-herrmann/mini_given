require "mini_given/version"
require 'minitest/spec'

module MiniGiven
  autoload :Spec, 'mini_given/spec'
end

MiniTest::Spec.send(:extend, MiniGiven::Spec)
