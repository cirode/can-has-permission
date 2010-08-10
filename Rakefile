require 'rubygems'
require 'rake'

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].each{|task| load task}

task :test do
  system("spec spec/tests/*_spec.rb")
end