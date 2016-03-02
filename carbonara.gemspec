# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carbonara/version'

Gem::Specification.new do |spec|
  spec.name          = "carbonara"
  spec.version       = Carbonara::VERSION
  spec.authors       = ["Groza Sergiu"]
  spec.email         = ["serioja90@gmail.com"]

  spec.summary       = %q{A simple gem for microservices initialization}
  spec.description   = %q{This gem provides a set of command line tools for new microservice directory initialization and other useful tools}
  spec.homepage      = "https://github.com/serioja90/carbonara"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
