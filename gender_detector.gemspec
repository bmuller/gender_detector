# encoding: utf-8
require File.expand_path('../lib/gender_detector/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "gender_detector"
  s.version = GenderDetector::VERSION

  s.authors = ["Brian Muller"]
  s.email = ["bamuller@gmail.com"]
  s.homepage = "https://github.com/bmuller/gender_detector"

  s.description = "Get gender from first name."
  s.summary = "Get gender from first name."

  s.require_paths = ["lib"]
  s.files = Dir['lib/**/*.rb'] | Dir['lib/**/data/nam_dict.txt']
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.0")

  s.add_dependency('unicode_utils', '>= 1.3.0')
  s.add_development_dependency('minitest')
  s.add_development_dependency("rake")
  s.add_development_dependency("rdoc")
end
