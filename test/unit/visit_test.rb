require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  # Start by using ActiveRecord macros
  # Relationship macros...
  should belong_to(:pet)
  should have_many(:vaccinations)
  should have_many(:vaccines).through(:vaccinations)
  should have_one(:owner).through(:pet)
  
  # Validation macros...
  should validate_presence_of(:pet_id)
  should validate_presence_of(:weight)
  should validate_presence_of(:date)
  
  # Validating weight...
  should allow_value(1).for(:weight)
  should allow_value(10).for(:weight)
  should allow_value(50).for(:weight)
  should allow_value(42).for(:weight)

  should_not allow_value("bad").for(:weight)
  should_not allow_value(0).for(:weight)
  should_not allow_value(-10).for(:weight)
  should_not allow_value(101).for(:weight)
  should_not allow_value(3.14159).for(:weight)
  

  # ---------------------------------
  # Testing other methods with a context
  context "Creating three visits from two pets" do
    # create the objects I want with factories
    setup do 
      @cat = Factory.create(:animal)
      @owner = Factory.create(:owner)
      @dusty = Factory.create(:pet, :animal => @cat, :owner => @owner)
      @polo = Factory.create(:pet, :animal => @cat, :owner => @owner, :name => "Polo")
      @visit1 = Factory.create(:visit, :pet => @dusty)
      @visit2 = Factory.create(:visit, :pet => @polo, :date => 5.months.ago.to_date)
      @visit3 = Factory.create(:visit, :pet => @polo, :date => 2.months.ago.to_date)
    end
    
    # and provide a teardown method as well
    teardown do
      @visit3.destroy
      @visit2.destroy
      @visit1.destroy
      @polo.destroy
      @dusty.destroy
      @owner.destroy
      @cat.destroy
    end
  
    # now run the tests:
    # test one of each factory (not really required, but not a bad idea)
    should "show that cat, owner, pet, visit is created properly" do
      assert_equal "Alex", @owner.first_name
      assert_equal "Cat", @cat.name
      assert_equal "Dusty", @dusty.name
      assert_equal 5, @visit1.weight
    end
    
    # test the named scope 'chronological'
    should "have all the visits are listed here in desc order" do
      assert_equal 3, Visit.chronological.size # quick check of size
      dates = Array.new
      # get array of visit dates in order
      [2,5,6].sort.each {|n| dates << n.months.ago.to_date}
      assert_equal dates, Visit.chronological.map{|v| v.date}
    end
    
    # test the named scope 'for_pet'
    should "have named scope for_pet that works" do
      assert_equal 1, Visit.for_pet(@dusty.id).size
      assert_equal 2, Visit.for_pet(@polo.id).size
    end
    
    # test the named scope 'last'
    should "have named scope last that works" do
      assert_equal 2, Visit.for_pet(@polo.id).last(5).size
      assert_equal 2, Visit.for_pet(@polo.id).last(2).size
      assert_equal 1, Visit.for_pet(@polo.id).last(1).size
    end
  end
end
