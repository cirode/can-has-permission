require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe CanHasPermission::Anonymous do
  it "created with a name should be valid" do
    CanHasPermission::Anonymous.find_or_create_by_name('name').should be_valid
  end
  
  it "created without a name should not be valid" do
    CanHasPermission::Anonymous.new().should be_invalid
  end
  
  it "created with an already used name should not be valid" do
    CanHasPermission::Anonymous.create!(:name => 'name')
    CanHasPermission::Anonymous.new(:name => 'name').should be_invalid
  end
  
  describe "creating an anonymous with permissions" do
    before(:each) do
      @role = CanHasPermission::Anonymous.create!(:name => 'user')
      @role.permissions.create!(:name => 'perm')
      @role.reload
    end
    it "should have an attached permission" do
      @role.permissions.should_not be_empty
    end
    describe "#can?" do
      it "should return true when given the permission" do
        @role.can?(:perm).should be_true
      end
      it "should return false when given a different permission" do
        @role.can?(:perm2).should be_false
      end
    end
  end
  
  describe "creating an anonymous with roles" do
    before(:each) do
      @role = CanHasPermission::Anonymous.create!(:name => 'user')
      @role.roles.create!(:name => 'perm')
      @role.reload
    end
    it "should have an attached role" do
      @role.roles.should_not be_empty
    end
    describe "#has_role?" do
      it "should return true when given the role" do
        @role.has_role?(:perm).should be_true
      end
      it "should return false when given a different role" do
        @role.has_role?(:perm2).should be_false
      end
    end
  end
  
  describe "creating a role_type with permissions" do
    before(:each) do
      @role_type_name = 'type'
      @role_type = CanHasPermission::Role.create!(:name => @role_type_name)
      @role_type.permissions.create!(:name => 'perm')
      @role_type.reload
    end
    describe "and adding the role to anon" do
      before(:each) do
        @role = CanHasPermission::Anonymous.create!(:name => 'user')
        @role.role_maps.create!(:role => @role_type)
      end
      describe "#can?" do
        it "should return true when given the permission" do
          @role.can?(:perm).should be_true
        end
        it "should return false when given a different permission" do
          @role.can?(:perm2).should be_false
        end
      end
    end
  end
  
  it "using nested attributes should save" do
    role =CanHasPermission::Role.create!(:name => 'role')
    anon = CanHasPermission::Anonymous.create(:name => 'user', :role_maps_attributes => [{:role => role}])
    anon.reload
    anon.role_maps.should_not be_empty
    anon.roles.should_not be_empty
    anon.role_maps.first.permissible_id.should_not be_nil
  end
  it "using nested attributes should save" do
    role =CanHasPermission::Permission.create!(:name => 'role')
    anon = CanHasPermission::Anonymous.create(:name => 'user', :permission_maps_attributes => [{:permission => role}])
    anon.reload
    anon.permission_maps.should_not be_empty
    anon.permissions.should_not be_empty
    anon.permission_maps.first.permissible_id.should_not be_nil
  end
end