require 'test_helper'

class VaccineTest < ActiveSupport::TestCase
  # Start by using ActiveRecord macros
  # Relationship macros...
  should have_many(:vaccinations)
  should have_many(:visits).through(:vaccinations)
  
  # Validation macros...
  should validate_presence_of(:name)
  should validate_presence_of(:animal_id)
  
  # Validating duration...
  should allow_value(365).for(:duration)
  should allow_value(1).for(:duration)
  should allow_value(7300).for(:duration)
  
  should_not allow_value("bad").for(:duration)
  should_not allow_value(0).for(:duration)
  should_not allow_value(-365).for(:duration)
  should_not allow_value(3.14159).for(:duration)  

  # ---------------------------------
  # Testing other methods with a context
  context "Creating vaccines" do
    # create the objects I want with factories
    setup do 
      @cat = Factory.create(:animal)
      @dog = Factory.create(:animal, :name => "Dog")
      @rabies = Factory.create(:vaccine, :name => "Rabies", :animal => @dog)
      @leukemia = Factory.create(:vaccine, :animal => @cat, :duration => nil)
      @heartworm = Factory.create(:vaccine, :name => "Heartworm", :animal => @dog)
    end
    
    # and provide a teardown method as well
    teardown do
      @heartworm.destroy
      @leukemia.destroy
      @rabies.destroy
      @dog.destroy
      @cat.destroy
    end
  
    # now run the tests:
    # test one of each factory (not really required, but not a bad idea)
    should "shows that Rabies is created properly" do
      assert_equal "Rabies", @rabies.name
      assert_equal 365, @rabies.duration
    end
    
    # test the lifetime vaccine callback
    should "shows that no duration is a lifetime vaccine" do
      assert_equal 7300, @leukemia.duration
    end
        
    # test the named scope 'alphabetical'
    should "and all the vaccines are listed here in alphabetical order" do
      assert_equal 3, Vaccine.alphabetical.size
      assert_equal ["Heartworm", "Leukemia", "Rabies"], Vaccine.alphabetical.map{|v| v.name}
    end
    
    # test the named scope 'for_animal'
    should "and all named scope for_animal works" do
      assert_equal 1, Vaccine.for_animal(@cat.id).size
      assert_equal 2, Vaccine.for_animal(@dog.id).size
    end
  end
end
