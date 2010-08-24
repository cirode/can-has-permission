module CanHasPermission
  class Permission < ActiveRecord::Base
    validates_presence_of :permission_type_id, :if => lambda{|instance| instance.name.blank?}
    validates_presence_of :permissible_id
    validates_presence_of :permissible_type
    validates_uniqueness_of :permissible_type, :permissible_id, :scope => :permissible_id
    before_save :create_permission, :unless => lambda{|instance| instance.name.blank?}
  
    belongs_to :permissible, :polymorphic => true
    belongs_to :permission_type, :class_name => 'CanHasPermission::PermissionType'
    
    def name=(permission)
      @permission = permission.to_s
    end
  
    #test this
    def name
      @permission || permission_type.try(:name)
    end
  
    protected
  
    def create_permission
      self.permission_type_id = CanHasPermission::PermissionType.find_or_create_by_name(:name => self.name).id
    end
  end
end