lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sexmachine/version'

Gem::Specification.new do |s|
  s.name = "sexmachine"
  s.version = SexMachine::VERSION
  s.authors = ["Brian Muller"]
  s.email = ["bamuller@gmail.com"]
  s.description = "Get gender from first name."
  s.summary = "Get gender from first name."
  s.files = `git ls-files`.split($/)
  s.homepage = "https://github.com/bmuller/sexmachine"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.0")
  s.add_dependency('unicode_utils', '>= 1.3.0')
  s.add_development_dependency('minitest')
  s.add_development_dependency("rake")
  s.add_development_dependency("rdoc")
end
