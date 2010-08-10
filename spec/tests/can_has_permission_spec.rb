require File.join(File.dirname(__FILE__), '..', 'spec_helper')


class TestingClass
  include CanHasPermission
  attr_accessor :id
  def initialize(id=nil)
    @@id ||=0
    self.id = id || (@@id +=1)
  end
  
  def self.find(id)
    self.class.new(id)
  end
end

describe CanHasPermission, "after including in TestingClass object" do
  before(:each) do
    @testing_object = TestingClass.new
  end
  describe ", TestingClass object " do
    it "should have #has_role?" do
      @testing_object.respond_to?(:has_role?).should be_true
    end
    it "should have #roles" do
      @testing_object.respond_to?(:roles).should be_true
    end
    it "should have #add_roles" do
      @testing_object.respond_to?(:add_roles).should be_true
    end
    it "should have #remove_roles" do
      @testing_object.respond_to?(:remove_roles).should be_true
    end
    it "should have #can?" do
      @testing_object.respond_to?(:can?).should be_true
    end
    it "should have #can" do
      @testing_object.respond_to?(:can).should be_true
    end
    it "should have #can=" do
      @testing_object.respond_to?(:can=).should be_true
    end
    it "should have #can_not" do
      @testing_object.respond_to?(:can_not).should be_true
    end
  end
  
  describe "with no permissions" do
    it "#can should return an empty list" do
      @testing_object.can.should be_empty
    end
    
    describe "#can?" do
      it "should return false with a symbol" do
        @testing_object.can?(:do_something).should be_false
      end
      it "should return false with a string" do
        @testing_object.can?('do_something').should be_false
      end
    end
    
    describe "#can=" do
      it "should accept an empty list" do
        @testing_object.can=([])
        @testing_object.can.should be_empty
      end
      it "should accept being given a list with items and treat them as strings" do
        @testing_object.can=[true]
        @testing_object.can.size.should == 1 
        @testing_object.can.first.should == true.to_s.to_sym
      end
      it "should treat any object as its string representation" do
        @testing_object.can=true
        @testing_object.can.size.should == 1 
        @testing_object.can.first.should == true.to_s.to_sym
      end
    end
  end
  
  describe "with permissions" do
    before(:each) do
      @testing_object.can=(:role1)
    end
    
    it "#can should return a filled list" do
      @testing_object.can.should_not be_empty
    end

    describe "#can?" do
      describe "when the permission isnt in the list" do
        it "should return false with a symbol" do
          @testing_object.can?(:do_something).should be_false
        end
        it "should return false with a string" do
          @testing_object.can?('do_something').should be_false
        end
      end
      describe "when the permission is in the list" do
        it "should return true with a symbol" do
          @testing_object.can?(:role1).should be_true
        end
        it "should return true with a string" do
          @testing_object.can?('role1').should be_true
        end
      end
    end

    describe "#can=" do
      it "should accept an empty list" do
        @testing_object.can=([])
        @testing_object.can.should_not be_empty
      end
      it "should accept being given a list with items and treat them as strings" do
        @testing_object.can=[true]
        @testing_object.can.size.should == 2 
        @testing_object.can.should include(true.to_s.to_sym)
      end
      it "should treat any object as its string representation" do
        @testing_object.can=true
        @testing_object.can.size.should == 2 
        @testing_object.can.should include(true.to_s.to_sym)
      end
      it "should accept an already added permission and change nothing" do
        @testing_object.can=(:role1)
        @testing_object.can.size.should == 1
        @testing_object.can.should include(:role1.to_s.to_sym)
      end
    end
    
    describe "#can_not" do
      it "should accept an empty list" do
        @testing_object.can_not([])
        @testing_object.can.should_not be_empty
      end
      it "should accept being given a list with items and treat them as strings" do
        @testing_object.can_not([:role1])
        @testing_object.can.should be_empty
        @testing_object.can.should_not include(:role1)
      end
      it "should treat any object as its string representation" do
        old_size = @testing_object.can.size
        @testing_object.can=(true)
        @testing_object.can_not(true)
        @testing_object.can.size.should == old_size
        @testing_object.can.should_not include(true.to_s.to_sym)
      end
      it "should accept a role not added and change nothing" do
        @testing_object.can_not(true)
        @testing_object.can.should_not be_empty
        @testing_object.can.should include(:role1)
      end
    end
  end
  
  describe "with no roles" do
    it "#roles should return an empty list" do
      @testing_object.roles.should be_empty
    end
    
    describe "#has_role?" do
      it "should return false with a symbol" do
        @testing_object.has_role?(:do_something).should be_false
      end
      it "should return false with a string" do
        @testing_object.has_role?('do_something').should be_false
      end
    end
    
    describe "#add_roles" do
      it "should accept an empty list" do
        @testing_object.add_roles([])
        @testing_object.roles.should be_empty
      end
      it "should accept being given a list with items and treat them as strings" do
        @testing_object.add_roles([true])
        @testing_object.roles.size.should == 1 
        @testing_object.roles.first.should == true.to_s.to_sym
      end
      it "should treat any object as its string representation" do
        @testing_object.add_roles(true)
        @testing_object.roles.size.should == 1 
        @testing_object.roles.first.should == true.to_s.to_sym
      end
    end
  end
  
  describe "with roles" do
    before(:each) do
      @testing_object.add_roles(:role1)
    end
    
    it "#roles should return a filled list" do
      @testing_object.roles.size.should == 1
    end
    
    describe "#has_role?" do
      describe "when the role isnt in the list" do
        it "should return false with a symbol" do
          @testing_object.has_role?(:do_something).should be_false
        end
        it "should return false with a string" do
          @testing_object.has_role?('do_something').should be_false
        end
      end
      describe "when the role is in the list" do
        it "should return true with a symbol" do
          @testing_object.has_role?(:role1).should be_true
        end
        it "should return true with a string" do
          @testing_object.has_role?('role1').should be_true
        end
      end
    end
    
    describe "#add_roles" do
      it "should accept an empty list" do
        @testing_object.add_roles([])
        @testing_object.roles.should_not be_empty
      end
      it "should accept being given a list with items and treat them as strings" do
        @testing_object.add_roles([true])
        @testing_object.roles.size.should == 2
        @testing_object.roles.should include(true.to_s.to_sym)
      end
      it "should treat any object as its string representation" do
        @testing_object.add_roles(true)
        @testing_object.roles.size.should == 2 
        @testing_object.roles.should include(true.to_s.to_sym)
      end
      it "should accept an already added role and change nothing" do
        @testing_object.add_roles(:role1)
        @testing_object.roles.size.should == 1
        @testing_object.roles.should include(:role1.to_s.to_sym)
      end
    end
    
    describe "#remove_roles" do
      it "should accept an empty list" do
        @testing_object.remove_roles([])
        @testing_object.roles.should_not be_empty
      end
      it "should accept being given a list with items and treat them as strings" do
        @testing_object.remove_roles([:role1])
        @testing_object.roles.should be_empty
        @testing_object.roles.should_not include(:role1)
      end
      it "should treat any object as its string representation" do
        old_size = @testing_object.roles.size
        @testing_object.add_roles(true)
        @testing_object.remove_roles(true)
        @testing_object.roles.size.should == old_size
        @testing_object.roles.should_not include(true.to_s.to_sym)
      end
      it "should accept a role not added and change nothing" do
        @testing_object.remove_roles(true)
        @testing_object.roles.should_not be_empty
        @testing_object.roles.should include(:role1)
      end
    end
    
    describe "#can?" do
      it "should return false" do
        @testing_object.can?(:do_stuff).should be_false
      end
    end
    
    describe "that have permissions" do
      before(:each) do
        role = CanHasPermission::Role.find(:first)
        role.can=(:do_stuff)
      end
      describe "#can?" do
        it "should return true when given a permission the role has" do
          @testing_object.can?(:do_stuff).should be_true
        end
      end
    end
  end
end