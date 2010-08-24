require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe CanHasPermission::Permission do
  it "created with all attributes should be valid" do
    role = CanHasPermission::Permission.new(:permissible_id => 1, :permissible_type => 'Object', :name => 'role')
    role.should be_valid
  end
  it "should be invalid without a name" do
    role = CanHasPermission::Permission.new(:permissible_id => 1, :permissible_type => 'Object')
    role.should be_invalid
  end
  it "two permissions with the same object should not be valid" do
    role1 = CanHasPermission::Permission.create!(:permissible_id => 1, :permissible_type => 'Object', :name => 'role')
    role2 = CanHasPermission::Permission.new(:permissible_id => 1, :permissible_type => 'Object', :name => 'role')
    role2.should_not be_valid
  end
  it "two permissions with different object ids should be valid" do
    role1 = CanHasPermission::Permission.create!(:permissible_id => 1, :permissible_type => 'Object', :name => 'role')
    role2 = CanHasPermission::Permission.new(:permissible_id => 2, :permissible_type => 'Object', :name => 'role')
    role2.should be_valid
  end
  describe "with a role type" do
    before(:each) do
      @role_type = CanHasPermission::PermissionType.create!(:name => 'role')
    end
    it "should be valid without a name" do
      role = CanHasPermission::Permission.new(:permissible_id => 1, :permissible_type => 'Object', :name => @role_type)
      role.should be_valid
    end
  end
  it "should be invalid without a permissible_id" do
    role = CanHasPermission::Permission.new(:permissible_type => 'Object', :name => 'role')
    role.should be_invalid
  end
  it "should be invalid without a permissible_type" do
    role = CanHasPermission::Permission.new(:permissible_id => 1, :name => 'role', :name => 'role')
    role.should be_invalid
  end
  describe "created with a name and not a permission" do
    before(:each) do
      @role_name = 'role'
      @role = CanHasPermission::Permission.create!(:permissible_id => 1, :permissible_type => 'Object', :name => @role_name)
    end
    it "should create a permission_type" do
      CanHasPermission::PermissionType.count(:conditions => {:name => @role_name}).should == 1
    end
    describe "and another role of the same permission is created" do
      before(:each) do
        @role2 = CanHasPermission::Permission.create!(:permissible_id => 2, :permissible_type => 'Object', :name => @role_name)        
      end
      it "should not create a second permission_type" do
        CanHasPermission::PermissionType.count(:conditions => {:name => @role_name}).should == 1        
      end
      it "both should have the same permission_type instance" do
        @role2.permission_type_id.should == @role.permission_type_id
      end
    end
  end
end