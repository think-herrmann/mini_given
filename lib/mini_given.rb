require "mini_given/version"
require 'minitest/spec'

module MiniGiven
  autoload :Spec, 'mini_given/spec'
end

Minitest::Spec.send(:extend, MiniGiven::Spec)
