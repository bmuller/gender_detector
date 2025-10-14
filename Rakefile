require 'rubygems'
require 'bundler'
require 'rdoc/task'

Bundler::GemHelper.install_tasks

desc "Create documentation"
RDoc::Task.new("doc") { |rdoc|
  rdoc.title = "SexMachine - Gender from first name"
  rdoc.rdoc_dir = 'docs'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
}

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => :test
