module CanHasPermission
  class Role < ActiveRecord::Base
    validates_presence_of :name
    validates_uniqueness_of :name
    has_many :role_maps, :class_name => 'CanHasPermission::RoleMap'
    has_many :permission_maps, :as => 'permissible', :class_name => 'CanHasPermission::PermissionMap'
    has_many :permissions, :through => :permission_maps
    
    def can?(permission)
      return true if (!self.permissions.select{|p| p.name == permission.to_s}.empty?)
      false
    end
  end
end