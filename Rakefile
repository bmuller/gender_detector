require 'bundler/gem_tasks'
require 'rdoc/task'
require 'rake/testtask'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

RDoc::Task.new('doc') do |rdoc|
  rdoc.title = 'GenderDetector - Detect gender from first name'
  rdoc.rdoc_dir = 'docs'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Run all unit tests'
Rake::TestTask.new('test') do |t|
  t.libs << 'lib'
  t.test_files = FileList['test/*.rb']
end

task default: %i[rubocop test]
