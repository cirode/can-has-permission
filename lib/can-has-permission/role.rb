module CanHasPermission
  class Role < ActiveRecord::Base
    validates_presence_of :role_type_id, :if => lambda{|instance| instance.name.blank?}
    validates_presence_of :permissible_id
    validates_presence_of :permissible_type
    validates_uniqueness_of :permissible_type, :permissible_id, :scope => :permissible_id
    before_save :create_role, :unless => lambda{|instance| instance.name.blank?}
  
    belongs_to :permissible, :polymorphic => true
    belongs_to :role_type, :class_name => 'CanHasPermission::RoleType'
  
    def name=(role)
      @role = role.to_s
    end
  
    def name
      @role || role_type.try(:name)
    end
  
    protected
    def create_role
      self.role_type_id = CanHasPermission::RoleType.find_or_create_by_name(:name => self.name).id
    end
  end
end