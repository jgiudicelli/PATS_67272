require 'test_helper'

class PetTest < ActiveSupport::TestCase
  # Start by using ActiveRecord macros
  # Relationship macros...
  should belong_to(:owner)
  should belong_to(:animal)
  should have_many(:visits)
  should have_many(:vaccinations).through(:visits)
  
  # Validation macros...
  should validate_presence_of(:name)
  should validate_presence_of(:animal_id)
  should validate_presence_of(:owner_id)
  

  # ---------------------------------
  # Testing other methods with a context
  context "Creating three pets from two owners" do
    # create the objects I want with factories
    setup do 
      @cat = Factory.create(:animal)
      @dog = Factory.create(:animal, :name => "Dog")
      @alex = Factory.create(:owner)
      @mark = Factory.create(:owner, :first_name => "Mark")
      @dusty = Factory.create(:pet, :animal => @cat, :owner => @alex, :female => false)
      @polo = Factory.create(:pet, :animal => @cat, :owner => @alex, :name => "Polo", :active => false)
      @pork_chop = Factory.create(:pet, :animal => @dog, :owner => @mark, :name => "Pork Chop")
    end
    
    # and provide a teardown method as well
    teardown do
      @pork_chop.destroy
      @polo.destroy
      @dusty.destroy
      @mark.destroy
      @alex.destroy
      @dog.destroy
      @cat.destroy
    end
  
    # now run the tests:
    # test one of each type of factory (not really required, but not a bad idea)
    should "show that cat, owner, pet is created properly" do
      assert_equal "Mark", @mark.first_name
      assert_equal "Dog", @dog.name
      assert_equal "Pork Chop", @pork_chop.name     
    end
    
    # test the scope 'alphabetical'
    should "have all the pets are listed here in alphabetical order" do
      assert_equal 3, Pet.all.size # quick check of size
      assert_equal ["Dusty", "Polo", "Pork Chop"], Pet.alphabetical.map{|p| p.name}
    end
    
    # test the scope 'active'
    should "have all active pets accounted for" do
      assert_equal 2, Pet.active.size 
    end
    
    # test the scope related to gender
    should "properly handle gender named scopes" do
      assert_equal 2, Pet.females.size 
      assert_equal 1, Pet.males.size 
    end
    
    # test the named scope 'for_owner'
    should "have named scope for_owner that works" do
      assert_equal 1, Pet.for_owner(@mark.id).size
      assert_equal 2, Pet.for_owner(@alex.id).size
    end    
    
    # test the named scope 'by_animal'
    should "have named scope by_animal that works" do
      assert_equal 1, Pet.by_animal(@dog.id).size
      assert_equal 2, Pet.by_animal(@cat.id).size
    end
    
    # test the method 'gender'
    should "have method gender that works" do
      assert_equal "Female", @polo.gender
      assert_equal "Female", @pork_chop.gender
      assert_equal "Male", @dusty.gender
    end
  end
end
