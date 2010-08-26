module CanHasPermission
  class Permission < ActiveRecord::Base
    validates_presence_of :name
    validates_uniqueness_of :name
    has_many :permission_maps, :class_name => 'CanHasPermission::PermissionMap'
  end
end