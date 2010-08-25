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
    files = [
      "lib/can-has-permission.rb",
      "lib/can-has-permission/anonymous.rb",
      "lib/can-has-permission/permission.rb",
      "lib/can-has-permission/permission_type.rb",
      "lib/can-has-permission/role.rb",
      "lib/can-has-permission/role_type.rb",
      "generators/can_has_permission_generator.rb",
      "generators/templates/can_has_permission_create_anonymous.rb",
      "generators/templates/can_has_permission_create_permission_types.rb",
      "generators/templates/can_has_permission_create_permissions.rb",
      "generators/templates/can_has_permission_create_role_types.rb",
      "generators/templates/can_has_permission_create_roles.rb"
      ]
    gemspec.files = files
    gemspec.homepage = "http://github.com/cirode/can-has-permission"
    gemspec.authors = ["Chris Rode"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end