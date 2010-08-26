require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe CanHasPermission::PermissionMap do
  it "created with all attributes should be valid" do
    role = CanHasPermission::PermissionMap.new(:permissible_id => 1, :permissible_type => 'Object', :permission_id => 1)
    role.should be_valid
  end
  it "should be invalid without an id" do
    role = CanHasPermission::PermissionMap.new(:permissible_id => 1, :permissible_type => 'Object')
    role.should be_invalid
  end
  it "two permissions with the same object should not be valid" do
    role1 = CanHasPermission::PermissionMap.create!(:permissible_id => 1, :permissible_type => 'Object', :permission_id => 1)
    role2 = CanHasPermission::PermissionMap.new(:permissible_id => 1, :permissible_type => 'Object', :permission_id => 1)
    role2.should_not be_valid
  end
  it "two permissions with different object ids should be valid" do
    role1 = CanHasPermission::PermissionMap.create!(:permissible_id => 1, :permissible_type => 'Object', :permission_id => 1)
    role2 = CanHasPermission::PermissionMap.new(:permissible_id => 2, :permissible_type => 'Object', :permission_id => 1)
    role2.should be_valid
  end
  it "two permissions with the same object but different roles should be valid" do
    role1 = CanHasPermission::PermissionMap.create!(:permissible_id => 1, :permissible_type => 'Object', :permission_id => 1)
    role2 = CanHasPermission::PermissionMap.new(:permissible_id => 2, :permissible_type => 'Object', :permission_id => 2)
    role2.should be_valid
  end
  describe "with a permission" do
    before(:each) do
      @role_type = CanHasPermission::Permission.create!(:name => 'role')
    end
    it "should be valid without a name" do
      role = CanHasPermission::PermissionMap.new(:permissible_id => 1, :permissible_type => 'Object', :permission => @role_type)
      role.should be_valid
    end
  end

end