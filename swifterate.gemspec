# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swifterate/version'

Gem::Specification.new do |spec|
  spec.name          = "swifterate"
  spec.version       = Swifterate::VERSION
  spec.authors       = ["Mike Enriquez"]
  spec.email         = ["mike@enriquez.me"]

  spec.summary       = %q{Swift code generator.}
  spec.description   = %q{Swift code generator. Generate strongly typed enums based on your Info.plist and Asset Catalog. No more magic strings!}
  spec.homepage      = "https://github.com/enriquez/swifterate"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "CFPropertyList", "~> 2.3"
  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "mustache", "~> 1.0"
end
