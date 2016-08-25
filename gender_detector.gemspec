# encoding: utf-8
require File.expand_path('../lib/gender_detector/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'gender_detector'
  s.version = GenderDetector::VERSION

  s.authors = ['Brian Muller']
  s.email = ['bamuller@gmail.com']
  s.homepage = 'https://github.com/bmuller/gender_detector'

  s.description = 'Get gender from first name.'
  s.summary = 'Get gender from first name.'

  s.require_paths = ['lib']
  s.files = Dir['lib/**/*.rb'] | Dir['lib/**/data/nam_dict.txt']
  s.required_ruby_version = Gem::Requirement.new('>= 1.9.0')
  s.post_install_message = "For unicode support you'll need to also "
  s.post_install_message += 'install the unicode_utils or activesupport gem'

  s.add_development_dependency('rubocop', '>= 0.42.0')
  s.add_development_dependency('minitest')
  s.add_development_dependency('minitest-stub-const')
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('unicode_utils', '>= 1.3.0')
  s.add_development_dependency('activesupport')
end
