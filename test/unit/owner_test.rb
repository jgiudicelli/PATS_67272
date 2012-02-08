require 'test_helper'

class OwnerTest < ActiveSupport::TestCase
  # Start by using ActiveRecord macros
  # Relationship macros...
  should have_many(:pets)
  should have_many(:visits).through(:pets)
  
  # Validation macros...
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_presence_of(:phone)
  
  # Validating email...
  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  # Validating phone...
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  
  # Validating zip...
  should allow_value("03431").for(:zip)
  should allow_value("15217").for(:zip)
  should allow_value("15090").for(:zip)
  
  should_not allow_value("fred").for(:zip)
  should_not allow_value("3431").for(:zip)
  should_not allow_value("15213-9843").for(:zip)
  should_not allow_value("15d32").for(:zip)
  
  # Validating state...
  should allow_value("PA").for(:state)
  should allow_value("WV").for(:state)
  should allow_value("OH").for(:state)
  should_not allow_value("bad").for(:state)
  should_not allow_value(10).for(:state)
  should_not allow_value("CA").for(:state)
  
  # ---------------------------------
  # Testing other methods with a context
  context "Creating three owners" do
    # create the objects I want with factories
    setup do 
      @alex = Factory.create(:owner)
      @mark = Factory.create(:owner, :first_name => "Mark", :phone => "412-268-8211")
      @rachel = Factory.create(:owner, :first_name => "Rachel", :active => false)
    end
    
    # and provide a teardown method as well
    teardown do
      @rachel.destroy
      @mark.destroy
      @alex.destroy
    end
  
    # now run the tests:
    # test one of each factory (not really required, but not a bad idea)
    should "show that all factories are properly created" do
      assert_equal "Alex", @alex.first_name
      assert_equal "Mark", @mark.first_name
      assert_equal "Rachel", @rachel.first_name
      assert_equal true, @alex.active
      assert_equal true, @mark.active
      assert_equal false, @rachel.active
    end
    
    # test the named scope 'all'
    should "shows that there are three owners in in alphabetical order" do
      assert_equal ["Alex", "Mark", "Rachel"], Owner.all.map{|o| o.first_name}
    end
    
    # test the named scope 'active'
    should "shows that there are two active" do
      assert_equal 2, Owner.active.size
    end
    
    # test the method 'name' works
    should "shows that name method works" do
      assert_equal "Heimann, Alex", @alex.name
    end
    
    # test the callback is working 'reformat_phone'
    should "shows that Mark's phone is stripped of non-digits" do
      assert_equal "4122688211", @mark.phone
    end
  end
end
