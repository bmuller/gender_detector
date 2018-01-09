
require File.expand_path('../lib/gender_detector/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'gender_detector'
  s.version = GenderDetector::VERSION

  s.authors = ['Brian Muller']
  s.email = ['bamuller@gmail.com']
  s.homepage = 'https://github.com/bmuller/gender_detector'

  s.description = 'Guess gender from first name, with multilingual support.'
  s.summary = 'Get gender from first name.'
  s.license = 'GPL-3.0'

  s.require_paths = ['lib']
  s.files = Dir['lib/**/*.rb'] | Dir['lib/**/data/nam_dict.txt']
  s.required_ruby_version = Gem::Requirement.new('>= 1.9.0')
  s.post_install_message = "For unicode support you'll need to also "
  s.post_install_message += 'install the unicode_utils or activesupport gem'

  s.add_development_dependency('rubocop', '~> 0.50')
  s.add_development_dependency('minitest', '~> 5.10')
  s.add_development_dependency('rake', '~> 12.1')
  # this is still needed for ruby 2.2 and 2.3
  s.add_development_dependency('activesupport', '~> 5.1')
  s.add_development_dependency('minitest-stub-const', '~> 0.6')
end
