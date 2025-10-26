# frozen_string_literal: true

require File.expand_path('lib/gender_detector/version', __dir__)

Gem::Specification.new do |s|
  s.name = 'gender_detector'
  s.version = GenderDetector::VERSION

  s.authors = ['Brian Muller']
  s.email = ['bamuller@gmail.com']
  s.homepage = 'https://github.com/bmuller/gender_detector'

  s.description = 'Guess gender from first name, with multilingual support.'
  s.summary = 'Get gender from first name.'
  s.license = 'MIT'

  s.require_paths = ['lib']
  s.files = Dir['lib/**/*.rb'] | Dir['lib/**/data/nam_dict.txt']
  s.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  s.metadata = {
    'changelog_uri' => "https://github.com/bmuller/gender_detector/releases/tag/v#{GenderDetector::VERSION}",
    'source_code_uri' => 'https://github.com/bmuller/gender_detector',
    'bug_tracker_uri' => 'https://github.com/bmuller/gender_detector/issues',
    'rubygems_mfa_required' => 'true'
  }
end
