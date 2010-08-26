module CanHasPermission
  class RoleMap < ActiveRecord::Base
    validates_presence_of :role_id
    #validates_presence_of :permissible_id
    #validates_presence_of :permissible_type
    validates_uniqueness_of :permissible_type, :permissible_id, :scope => :permissible_id
  
    belongs_to :permissible, :polymorphic => true
    belongs_to :role, :class_name => 'CanHasPermission::Role'
  end
end