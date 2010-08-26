require 'rails_generator'
class CanHasPermissionGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template "can_has_permission_create_anonymous.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_anonymous" }
      m.migration_template "can_has_permission_create_permission_maps.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_permission_maps" }
      m.migration_template "can_has_permission_create_roles.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_roles" }
      m.migration_template "can_has_permission_create_permissions.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_permissions" }
      m.migration_template "can_has_permission_create_role_maps.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_role_maps" }
    end
  end
end