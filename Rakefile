require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'xml-sax-machines'
    gem.summary     = %q{Assorted XML SAX readers, filters and writers.}
    gem.description = %q{XML SAX Machines}
    gem.email       = 'shane.hanna@gmail.com'
    gem.homepage    = 'http://github.com/shanna/xml-sax-machines'
    gem.authors     = ['Shane Hanna']
    gem.add_dependency 'nokogiri', ['>= 1.4']
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :test    => :check_dependencies
task :default => :test

require 'yard'
YARD::Rake::YardocTask.new do |yard|
  yard.files   = ['lib/**/*.rb']
end

