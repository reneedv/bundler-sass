# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/lib/sass_creator')
require File.expand_path(File.dirname(__FILE__) + '/lib/sass_sort')
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
  gem.name = "bundler-sass"
  gem.homepage = "http://github.com/vogelbek/bundler-sass"
  gem.license = "MIT"
  gem.summary = %Q{Builds a manifest file for all your sass partials}
  gem.description = %Q{As opposed to manually building a manifest file for all those sass partials, let this rake task take care of it.}
  gem.email = "adam@nird.us"
  gem.authors = ["Adam Hendricksen"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bundler-sass #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Look at all Sass partials in a folder and build a manifest"
task :build_manifest do
  include SassSort
  include SassCreator
  ENV['filename'] ||= "manifest.sass"
  import_array = SassSort.import_order
  manifest_hash = {ENV['filename'] => import_array}
  manifest = SassCreator::SassFile.new manifest_hash
  manifest.build_imports
end