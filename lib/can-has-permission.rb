module CanHasPermission
  
  def self.included(base)
    base.class_eval do
      has_many :roles, :as => 'permissible', :class_name => 'CanHasPermission::Role'
      has_many :permissions, :as => 'permissible', :class_name => 'CanHasPermission::Permission'
      accepts_nested_attributes_for :permissions
      accepts_nested_attributes_for :roles
    end
  end
  
  def can?(permission)
    return true if (!self.permissions.select{|p| p.name == permission.to_s}.empty?)
    self.roles.each do |role|
      return true if role.role_type.can?(permission)
    end
    false
  end

  def has_role?(role)
    !self.roles.select{|r| r.name == role.to_s}.empty?
  end
end

require File.join(File.dirname(__FILE__), 'can-has-permission', 'permission')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'permission_type')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'role')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'role_type')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'anonymous')