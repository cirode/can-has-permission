module CanHasPermission
  class RoleType < ActiveRecord::Base
    validates_presence_of :name
    validates_uniqueness_of :name
    has_many :roles, :class_name => 'CanHasPermission::Role'
    has_many :permissions, :as => 'permissible', :class_name => 'CanHasPermission::Permission'
    accepts_nested_attributes_for :permissions
    
    def can?(permission)
      return true if (!self.permissions.select{|p| p.name == permission.to_s}.empty?)
      false
    end
  end
end