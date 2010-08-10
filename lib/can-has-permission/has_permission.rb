class CanHasPermission::HasPermission < ActiveRecord::Base
  validates_presence_of :permission_id, :if => lambda{|instance| instance.permission.blank?}
  validates_presence_of :model_id
  validates_presence_of :model
  validates_uniqueness_of :model, :model_id, :scope => :permission_id
  before_save :create_permission, :unless => lambda{|instance| instance.permission.blank?}
  
  belongs_to :permission_class, :class_name => 'CanHasPermission::Permission', :foreign_key => 'permission_id'
  
  def permission=(permission)
    @permission = permission.to_s
  end
  
  #test this
  def permission
    permission_class.try(:name).try(:to_sym) || @permission
  end
  
  protected
  
  def create_permission
    self.permission_id = CanHasPermission::Permission.find_or_create_by_name(:name => self.permission).id
  end
end