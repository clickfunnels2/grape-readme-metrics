# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "grape/readme/metrics/version"

Gem::Specification.new do |spec|
  spec.name          = "grape-readme-metrics"
  spec.version       = Grape::ReadMe::Metrics::VERSION
  spec.authors       = ["Nick Schneble"]
  spec.email         = ["nschneble@users.noreply.github.com "]

  spec.summary       = %q{Grape DSL to log Readme metrics.}
  spec.description   = %q{Grape middleware to log ReadMe metrics for Grape API endpoints.}
  spec.homepage      = "https://github.com/clickfunnels2/grape-readme-metrics"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "grape", ">= 0.16", "< 2.0"
  spec.add_dependency "activemodel", ">= 4.0"
  spec.add_dependency "activesupport", ">= 4.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "httparty", "~> 0.14"
  spec.add_runtime_dependency "uuid", "~> 2.3.8"
  spec.add_runtime_dependency "os", "~> 1.1.4"
end
