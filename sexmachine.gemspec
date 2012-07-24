$:.push File.expand_path("../lib", __FILE__)
require "sexmachine/version"
require "rake"
require "date"

Gem::Specification.new do |s|
  s.name = "sexmachine"
  s.version = SexMachine::VERSION
  s.authors = ["Brian Muller"]
  s.date = Date.today.to_s
  s.description = "Get gender from first name."
  s.summary = "Get gender from first name."
  s.email = "brian.muller@livingsocial.com"
  s.files = FileList["lib/**/*", "[A-Z]*", "Rakefile", "docs/**/*"]
  s.homepage = "https://github.com/bmuller/sexmachine"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubyforge_project = "sexmachine"
end
