# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{can-has-permission}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Rode"]
  s.date = %q{2010-08-26}
  s.description = %q{simple permissions based authorisation with roles}
  s.email = %q{cirode@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "generators/can_has_permission_generator.rb",
     "generators/templates/can_has_permission_create_anonymous.rb",
     "generators/templates/can_has_permission_create_permission_maps.rb",
     "generators/templates/can_has_permission_create_role_maps.rb",
     "lib/action_controller.rb",
     "lib/can-has-permission.rb",
     "lib/can-has-permission/anonymous.rb",
     "lib/can-has-permission/permission.rb",
     "lib/can-has-permission/permission_map.rb",
     "lib/can-has-permission/role.rb",
     "lib/can-has-permission/role_map.rb"
  ]
  s.homepage = %q{http://github.com/cirode/can-has-permission}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{simple permissions based authorisation}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/tests/anonymous_spec.rb",
     "spec/tests/permission_map_spec.rb",
     "spec/tests/permission_spec.rb",
     "spec/tests/role_map_spec.rb",
     "spec/tests/role_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

