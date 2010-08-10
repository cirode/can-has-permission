require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe CanHasPermission::HasRole do
  it "should be valid with a role_id, type and model_id" do
    has_role = CanHasPermission::HasRole.new(:role_id => 1, :model => 'Bingo', :model_id => 1)
    has_role.should be_valid
  end
  it "should not be valid without a role_id" do
    has_role = CanHasPermission::HasRole.new(:model => 'Bingo', :model_id => 1)
    has_role.should_not be_valid
  end
  it "should not be valid without a type" do
    has_role = CanHasPermission::HasRole.new(:role_id => 1, :model_id => 1)
    has_role.should_not be_valid
  end
  it "should not be valid without a model_id" do
    has_role = CanHasPermission::HasRole.new(:role_id => 1, :model => 'Type')
    has_role.should_not be_valid
  end
  it "should not be valid when it has a role_id, model_id and type that already exist" do
    name = 'the same'
    has_role1 = CanHasPermission::HasRole.create!(:role_id => 1, :model => 'Bingo', :model_id => 1)
    has_role2 = CanHasPermission::HasRole.new(:role_id => 1, :model => 'Bingo', :model_id => 1)
    has_role1.should be_valid
    has_role1.id.should_not be_nil
    has_role2.should_not be_valid
  end
  describe "when a role exists" do
    before(:each) do
      CanHasPermission::Role.create!(:name => 'this_exists')
      @role_count = CanHasPermission::Role.count
    end
    it "should be valid without a role_id but with the role name" do
      has_role = CanHasPermission::HasRole.new(:model => 'Bingo', :role => 'this_exists', :model_id => 1)
      has_role.should be_valid
    end
    it "should be valid without a role_id but with the role name as a symbol" do
      has_role = CanHasPermission::HasRole.new(:model => 'Bingo', :role => :this_exists, :model_id => 1)
      has_role.should be_valid
    end
    it "should not create another role" do
      CanHasPermission::HasRole.create!(:model => 'Bingo', :role => 'this_exists', :model_id => 1)
      CanHasPermission::Role.count.should == @role_count
    end
  end
  
  describe "when a role does not exist" do
    before(:each) do
      CanHasPermission::Role.count.should ==0
    end
    it "should be valid without a role_id but with the role name" do
      has_role = CanHasPermission::HasRole.new(:model => 'Bingo', :role => 'this_exists', :model_id => 1)
      has_role.should be_valid
    end
    it "should be valid without a role_id but with the role name as a symbol" do
      has_role = CanHasPermission::HasRole.new(:model => 'Bingo', :role => :this_exists, :model_id => 1)
      has_role.should be_valid
    end
    it "should create the role" do
      has_role = CanHasPermission::HasRole.create!(:model => 'Bingo2', :role => 'this_exists', :model_id => 1)
      CanHasPermission::Role.count.should == 1
      CanHasPermission::Role.find_by_name('this_exists').should_not be_nil
    end
    it "should create the role with symbol" do
      has_role = CanHasPermission::HasRole.create!(:model => 'Bingo2', :role => :this_exists, :model_id => 1)
      CanHasPermission::Role.count.should == 1
      CanHasPermission::Role.find_by_name('this_exists').should_not be_nil
    end
    it "should be invalid with a blank role" do
      has_role = CanHasPermission::HasRole.new(:model => 'Bingo', :role => '', :model_id => 1)
      has_role.should be_invalid
    end
  end
end