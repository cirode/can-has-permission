require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe CanHasPermission::HasPermission do
  it "should be valid with a permission_id, type and model_id" do
    has_permission = CanHasPermission::HasPermission.new(:permission_id => 1, :model => 'Bingo', :model_id => 1)
    has_permission.should be_valid
  end
  it "should not be valid without a permission_id" do
    has_permission = CanHasPermission::HasPermission.new(:model => 'Bingo', :model_id => 1)
    has_permission.should_not be_valid
  end
  it "should not be valid without a type" do
    has_permission = CanHasPermission::HasPermission.new(:permission_id => 1, :model_id => 1)
    has_permission.should_not be_valid
  end
  it "should not be valid without a model_id" do
    has_permission = CanHasPermission::HasPermission.new(:permission_id => 1, :model => 'Type')
    has_permission.should_not be_valid
  end
  it "should not be valid when it has a permission_id, model_id and type that already exist" do
    name = 'the same'
    has_permission1 = CanHasPermission::HasPermission.create!(:permission_id => 1, :model => 'Bingo', :model_id => 1)
    has_permission2 = CanHasPermission::HasPermission.new(:permission_id => 1, :model => 'Bingo', :model_id => 1)
    has_permission1.should be_valid
    has_permission1.id.should_not be_nil
    has_permission2.should_not be_valid
  end
  describe "when a permission exists" do
    before(:each) do
      CanHasPermission::Permission.create!(:name => 'this_exists')
      @permission_count = CanHasPermission::Permission.count
    end
    it "should be valid without a permission_id but with the permission name" do
      has_permission = CanHasPermission::HasPermission.new(:model => 'Bingo', :permission => 'this_exists', :model_id => 1)
      has_permission.should be_valid
    end
    it "should be valid without a permission_id but with the permission name as a symbol" do
      has_permission = CanHasPermission::HasPermission.new(:model => 'Bingo', :permission => :this_exists, :model_id => 1)
      has_permission.should be_valid
    end
    it "should not create another permission" do
      CanHasPermission::HasPermission.create!(:model => 'Bingo', :permission => 'this_exists', :model_id => 1)
      CanHasPermission::Permission.count.should == @permission_count
    end
  end
  
  describe "when a permission does not exist" do
    before(:each) do
      CanHasPermission::Permission.count.should ==0
    end
    it "should be valid without a permission_id but with the permission name" do
      has_permission = CanHasPermission::HasPermission.new(:model => 'Bingo', :permission => 'this_exists', :model_id => 1)
      has_permission.should be_valid
    end
    it "should be valid without a permission_id but with the permission name as a symbol" do
      has_permission = CanHasPermission::HasPermission.new(:model => 'Bingo', :permission => :this_exists, :model_id => 1)
      has_permission.should be_valid
    end
    it "should create the permission" do
      has_permission = CanHasPermission::HasPermission.create!(:model => 'Bingo2', :permission => 'this_exists', :model_id => 1)
      CanHasPermission::Permission.count.should == 1
      CanHasPermission::Permission.find_by_name('this_exists').should_not be_nil
    end
    it "should create the permission with symbol" do
      has_permission = CanHasPermission::HasPermission.create!(:model => 'Bingo2', :permission => :this_exists, :model_id => 1)
      CanHasPermission::Permission.count.should == 1
      CanHasPermission::Permission.find_by_name('this_exists').should_not be_nil
    end
    it "should be invalid with a blank permission" do
      has_permission = CanHasPermission::HasPermission.new(:model => 'Bingo', :permission => '', :model_id => 1)
      has_permission.should be_invalid
    end
  end
end