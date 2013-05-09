# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backgrounder/version'

Gem::Specification.new do |spec|
  spec.name          = "backgrounder"
  spec.version       = Backgrounder::VERSION
  spec.authors       = ["Zbigniew Humeniuk"]
  spec.email         = ["zbigniew.humeniuk@gmail.com"]
  spec.description   = %q{Create background jobs using Redis with ease.}
  spec.summary       = %q{Create background jobs using Redis with ease.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 3.0.0'
  spec.add_dependency 'resque', '>= 1.24.1'
  spec.add_dependency 'json', '>= 1.7.7'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13.0"
  spec.add_development_dependency "resque_spec", "~> 0.13.0"
end
