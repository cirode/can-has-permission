module CanHasPermission
  def can
    CanHasPermission::HasPermission.find(:all, :conditions => { :model => self.class.to_s, :model_id => self.id}).collect{|has_perm| has_perm.permission}
  end
  
  def can?(permission)
    role_ids = []
    CanHasPermission::HasRole.find(:all, :conditions => { :model => self.class.to_s, :model_id => self.id}).each do |role|
      role_ids << role.id
    end
    CanHasPermission::HasPermission.find(:first,:include=>[:permission_class], :conditions => ['((model =? and model_id =? ) or (model=? and model_id in (?) ))and permissions.name=?',self.class.to_s, self.id,CanHasPermission::Role.to_s,role_ids, permission.to_s]) != nil
  end
  
  def can=(permission_list)
    permission_list = [permission_list] unless permission_list.respond_to?(:each)
    permission_list.each do |permission|
      #if database is down then catestrophic error
      CanHasPermission::HasPermission.create!(:permission =>permission.to_s, :model => self.class.to_s, :model_id => self.id) unless self.can?(permission)
    end
  end
  
  def can_not(permission_list)
    permission_list = [permission_list] unless permission_list.respond_to?(:each)
    CanHasPermission::HasPermission.find(:all,:include=>[:permission_class], :conditions => ['model =? and model_id =? and permissions.name in (?)',self.class.to_s, self.id, permission_list.collect{|p| p.to_s}]).each do |has_permission|
      has_permission.destroy
    end
  end
  
  def has_role?(role)
    CanHasPermission::HasRole.find(:first,:include=>[:role_class], :conditions => ['model =? and model_id =? and roles.name=?',self.class.to_s, self.id, role.to_s]) != nil
  end
  
  def roles
    CanHasPermission::HasRole.find(:all, :conditions => { :model => self.class.to_s, :model_id => self.id}).collect{|has_role| has_role.role}
  end
  
  def add_roles(role_list)
    role_list = [role_list] unless role_list.respond_to?(:each)
    role_list.each do |role|
      #if database is down then catestrophic error
      CanHasPermission::HasRole.create!(:role =>role.to_s, :model => self.class.to_s, :model_id => self.id) unless self.has_role?(role)
    end
  end
  
  def remove_roles(role_list)
    role_list = [role_list] unless role_list.respond_to?(:each)
    CanHasPermission::HasRole.find(:all,:include=>[:role_class], :conditions => ['model =? and model_id =? and roles.name in (?)',self.class.to_s, self.id, role_list.collect{|p| p.to_s}]).each do |has_role|
      has_role.destroy
    end
  end
end

require File.join(File.dirname(__FILE__), 'can-has-permission', 'has_permission')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'permission')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'role')
require File.join(File.dirname(__FILE__), 'can-has-permission', 'has_role')