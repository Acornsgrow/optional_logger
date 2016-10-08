# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'optional_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "optional_logger"
  spec.version       = OptionalLogger::VERSION
  spec.authors       = ["Andrew De Ponte"]
  spec.email         = ["cyphactor@gmail.com"]

  spec.summary       = %q{Logger proxy to handle optionality of presence of a logger}
  spec.description   = %q{Logger proxy to handle optionality of presence of a logger}
  spec.homepage      = "http://github.com/Acornsgrow/optional_logger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
