class CanHasPermission::HasRole < ActiveRecord::Base
  validates_presence_of :role_id, :if => lambda{|instance| instance.role.blank?}
  validates_presence_of :model_id
  validates_presence_of :model
  validates_uniqueness_of :model, :model_id, :scope => :role_id
  before_save :create_role, :unless => lambda{|instance| instance.role.blank?}
  
  belongs_to :role_class, :class_name => 'CanHasPermission::Role', :foreign_key => 'role_id'
  
  #write and test a callback that changes the role on save if changed
  def role=(role)
    @role = role.to_s
  end
  #test this
  def role
    role_class.try(:name).try(:to_sym) || @role
  end
  protected
  def create_role
    self.role_id = CanHasPermission::Role.find_or_create_by_name(:name => self.role).id
  end
end