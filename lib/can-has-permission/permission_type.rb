module CanHasPermission
  class PermissionType < ActiveRecord::Base
    validates_presence_of :name
    validates_uniqueness_of :name
    has_many :permissions, :class_name => 'CanHasPermission::Permission'
  end
end