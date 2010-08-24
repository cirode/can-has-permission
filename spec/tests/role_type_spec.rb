require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe CanHasPermission::RoleType do
  it "should be valid with a name" do
    role = CanHasPermission::RoleType.new(:name => 'Bingo')
    role.should be_valid
  end
  it "should not be valid without a name" do
    role = CanHasPermission::RoleType.new()
    role.should_not be_valid
  end
  it "should not be valid when it has a name that already exists" do
    name = 'the same'
    role1 = CanHasPermission::RoleType.create!(:name => 'the same')
    role2 = CanHasPermission::RoleType.new(:name => 'the same')
    role1.should be_valid
    role1.id.should_not be_nil
    role2.should_not be_valid
  end
  describe "creating a role_type with permissions" do
    before(:each) do
      @role = CanHasPermission::RoleType.create!(:name => 'joe')
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
end