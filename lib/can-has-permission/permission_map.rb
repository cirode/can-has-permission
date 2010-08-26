module CanHasPermission
  class PermissionMap < ActiveRecord::Base
    validates_presence_of :permission_id
    #validates_presence_of :permissible_id
    #validates_presence_of :permissible_type
    validates_uniqueness_of :permissible_type, :permissible_id, :scope => :permissible_id
  
    belongs_to :permissible, :polymorphic => true
    belongs_to :permission, :class_name => 'CanHasPermission::Permission'
  end
end