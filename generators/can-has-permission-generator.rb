class CanHasPermissionGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template "migrate/can_has_permission_has_anonymous.rb", "db/migrate"
      m.migration_template "migrate/can_has_permission_has_permissions.rb", "db/migrate"
      m.migration_template "migrate/can_has_permission_has_roles.rb", "db/migrate"
      m.migration_template "migrate/can_has_permission_permissions.rb", "db/migrate"
      m.migration_template "migrate/can_has_permission_roles.rb", "db/migrate"
    end
  end
end