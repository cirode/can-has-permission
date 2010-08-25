require 'rails_generator'
class CanHasPermissionGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template "can_has_permission_create_anonymous.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_anonymous" }
      m.migration_template "can_has_permission_create_permissions.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_permissions" }
      m.migration_template "can_has_permission_create_role_types.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_role_types" }
      m.migration_template "can_has_permission_create_permission_types.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_permission_types" }
      m.migration_template "can_has_permission_create_roles.rb", "db/migrate",
                            { :migration_file_name => "can_has_permission_create_roles" }
    end
  end
end