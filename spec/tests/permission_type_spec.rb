require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe CanHasPermission::PermissionType do
  it "should be valid with a name" do
    role = CanHasPermission::PermissionType.new(:name => 'Bingo')
    role.should be_valid
  end
  it "should not be valid without a name" do
    role = CanHasPermission::PermissionType.new()
    role.should_not be_valid
  end
  it "should not be valid when it has a name that already exists" do
    name = 'the same'
    role1 = CanHasPermission::PermissionType.create!(:name => 'the same')
    role2 = CanHasPermission::PermissionType.new(:name => 'the same')
    role1.should be_valid
    role1.id.should_not be_nil
    role2.should_not be_valid
  end
end