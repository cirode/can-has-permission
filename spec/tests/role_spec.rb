require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe CanHasPermission::Role do
  it "created with all attributes should be valid" do
    role = CanHasPermission::Role.new(:permissible_id => 1, :permissible_type => 'Object', :name => 'role')
    role.should be_valid
  end
  it "should be invalid without a name" do
    role = CanHasPermission::Role.new(:permissible_id => 1, :permissible_type => 'Object')
    role.should be_invalid
  end
  it "two roles with the same object and role should not be valid" do
    role1 = CanHasPermission::Role.create!(:permissible_id => 1, :permissible_type => 'Object', :name => 'role')
    role2 = CanHasPermission::Role.new(:permissible_id => 1, :permissible_type => 'Object', :name => 'role')
    role2.should_not be_valid
  end
  it "two roles with the same object should be valid" do
    role1 = CanHasPermission::Role.create!(:permissible_id => 1, :permissible_type => 'Object', :name => 'role')
    role2 = CanHasPermission::Role.new(:permissible_id => 2, :permissible_type => 'Object', :name => 'role')
    role2.should be_valid
  end
  describe "with a role type" do
    before(:each) do
      @role_type = CanHasPermission::RoleType.create!(:name => 'role')
    end
    it "should be valid without a name" do
      role = CanHasPermission::Role.new(:permissible_id => 1, :permissible_type => 'Object', :role_type => @role_type)
      role.should be_valid
    end
  end
  it "should be invalid without a permissible_id" do
    role = CanHasPermission::Role.new(:permissible_type => 'Object', :name => 'role')
    role.should be_invalid
  end
  it "should be invalid without a permissible_type" do
    role = CanHasPermission::Role.new(:permissible_id => 1, :name => 'role', :name => 'role')
    role.should be_invalid
  end
  describe "created with a name and not a type" do
    before(:each) do
      @role_name = 'role'
      @role = CanHasPermission::Role.create!(:permissible_id => 1, :permissible_type => 'Object', :name => @role_name)
    end
    it "should create a role_type" do
      CanHasPermission::RoleType.count(:conditions => {:name => @role_name}).should == 1
    end
    describe "and another role of the same type is created" do
      before(:each) do
        @role2 = CanHasPermission::Role.create!(:permissible_id => 2, :permissible_type => 'Object', :name => @role_name)        
      end
      it "should not create a second role_type" do
        CanHasPermission::RoleType.count(:conditions => {:name => @role_name}).should == 1        
      end
      it "both should have the same role_type instance" do
        @role2.role_type_id.should == @role.role_type_id
      end
    end
  end
end