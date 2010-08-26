module CanHasPermission
  
  def self.included(base)
    base.class_eval do
      has_many :role_maps, :as => 'permissible', :class_name => 'CanHasPermission::RoleMap'
      has_many :permission_maps, :as => 'permissible', :class_name => 'CanHasPermission::PermissionMap'
      has_many :permissions, :through => :permission_maps
      has_many :roles, :through => :role_maps
      accepts_nested_attributes_for :role_maps
      accepts_nested_attributes_for :permission_maps
    end
  end
  
  def can?(permission)
    return true if (!self.permissions.select{|p| p.name == permission.to_s}.empty?)
    self.roles.each do |role|
      return true if role.can?(permission)
    end
    false
  end

  def has_role?(role)
    !self.roles.select{|r| r.name == role.to_s}.empty?
  end
end

require File.join(File.dirname(__FILE__), 'can-has-permission', 'permission_map')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'permission')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'role_map')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'role')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'anonymous')