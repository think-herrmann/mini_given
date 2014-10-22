# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mini_given/version'

Gem::Specification.new do |spec|
  spec.name          = "mini_given"
  spec.version       = MiniGiven::VERSION
  spec.authors       = ["Andrew Swerlick"]
  spec.email         = ["andrew.swerlick@hbdi.com"]
  spec.summary       = %q{
  A gem that extends minitest with a few new methods to make it easy to share setup code
  between spec tests.
  }
  spec.description   = %q{
  A gem that extends minitest with a few new methods to make it easy to share setup code
  between spec tests.

  It allows you to take common setup scenarios and extract them into modules that
  can be used across multiple tests. It also offers some features to allow for
  you to chain together multiple scenarios and use the output of one as parameters
  into the next.

  All of this is wrapped up in a lightweight bdd style syntax.
  }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake"
end
