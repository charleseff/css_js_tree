require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'rspec/core/rake_task'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the css_tree plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the css_tree plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'CssJsTree'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :spec do
  desc "Run unit specs"
    RSpec::Core::RakeTask.new('unit') do |t|
#    t.rspec_opts = ['--options', "spec/spec.opts"]
    t.pattern = FileList['spec/**/*_spec.rb']
  end
end

desc "Run the unit and acceptance specs"
task :spec => ['spec:unit']
