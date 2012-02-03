require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "iban-check"
  gem.homepage = "http://github.com/LTe/iban-check"
  gem.license = "MIT"
  gem.summary = %Q{Valid IBAN number}
  gem.description = %Q{Ruby class to validate iban numbers}
  gem.email = "piotr.nielacny@gmail.com"
  gem.authors = ["Piotr Niełacny"]
end
Jeweler::RubygemsDotOrgTasks.new

desc "Run specs"
task :spec do
  raise unless system 'bundle exec rspec spec'
end

task :default => [:spec]

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "iban-check #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
