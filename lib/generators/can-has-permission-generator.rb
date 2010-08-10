class CanHasPermissionGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template "migrate/create_roles.rb", "db/migrate"
    end
  end
end