require 'rubygems'
require 'rake'

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].each{|task| load task}

task :test do
  system("spec spec/tests/*_spec.rb")
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "can-has-permission"
    gemspec.summary = "simple permissions based authorisation"
    gemspec.description = "simple permissions based authorisation with roles"
    gemspec.email = "cirode@gmail.com"
    gemspec.homepage = "http://github.com/cirode/can_has_permission"
    gemspec.authors = ["Chris Rode"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end