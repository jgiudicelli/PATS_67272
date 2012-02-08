require 'test_helper'

# NOTE: validates_inclusion_of :vaccine_id doesn't play nice with Shoulda
# and needs to be commented out before running tests

class VaccinationTest < ActiveSupport::TestCase
  # Start by using ActiveRecord macros
  # Relationship macros...
  should belong_to(:visit)
  should belong_to(:vaccine)

  # Validation macros...
  should validate_presence_of(:vaccine_id)
  should validate_presence_of(:visit_id)
  
  # ---------------------------------
  # Testing other methods with a context
  context "Creating four vaccinations from three visits from two pets" do
    # create the objects I want with factories
    setup do 
      @cat = Factory.create(:animal)
      @dog = Factory.create(:animal, :name => "Dog")
      @rabies = Factory.create(:vaccine, :name => "Rabies", :animal => @dog)
      @leukemia = Factory.create(:vaccine, :animal => @cat, :duration => nil)
      @heartworm = Factory.create(:vaccine, :name => "Heartworm", :animal => @dog)
      @alex = Factory.create(:owner)
      @mark = Factory.create(:owner, :first_name => "Mark")
      @dusty = Factory.create(:pet, :animal => @cat, :owner => @alex, :female => false)
      @polo = Factory.create(:pet, :animal => @cat, :owner => @alex, :name => "Polo")
      @pork_chop = Factory.create(:pet, :animal => @dog, :owner => @mark, :name => "Pork Chop")
      @bama = Factory.create(:pet, :animal => @cat, :owner => @alex, :name => "Bama")
      @visit1 = Factory.create(:visit, :pet => @dusty)
      @visit2 = Factory.create(:visit, :pet => @polo, :date => 5.months.ago.to_date)
      @visit3 = Factory.create(:visit, :pet => @polo, :date => 3.months.ago.to_date)
      @visit4 = Factory.create(:visit, :pet => @bama, :date => 2.months.ago.to_date)
      @vacc1 = Factory.create(:vaccination, :visit => @visit1, :vaccine => @leukemia)
      @vacc2 = Factory.create(:vaccination, :visit => @visit2, :vaccine => @rabies)
      @vacc3 = Factory.create(:vaccination, :visit => @visit2, :vaccine => @leukemia)
      @vacc4 = Factory.create(:vaccination, :visit => @visit3, :vaccine => @leukemia)
      @vacc5 = Factory.create(:vaccination, :visit => @visit4, :vaccine => @heartworm)
    end
    
    # and provide a teardown method as well
    teardown do
      @cat.destroy
      @dog.destroy
      @rabies.destroy
      @leukemia.destroy
      @heartworm.destroy
      @alex.destroy
      @mark.destroy
      @dusty.destroy
      @polo.destroy
      @pork_chop.destroy
      @bama.destroy
      @visit1.destroy
      @visit2.destroy
      @visit3.destroy
      @visit4.destroy
      @vacc1.destroy
      @vacc2.destroy
      @vacc3.destroy
      @vacc4.destroy
      @vacc5.destroy
    end
  
    # now run the tests:
    # test one of each factory (not really required, but not a bad idea)
    should "show that cat, owner, pet, vaccine, visit is created properly" do
      assert_equal "Alex", @alex.first_name
      assert_equal "Cat", @cat.name
      assert_equal "Dusty", @dusty.name
      assert_equal "Rabies", @rabies.name
      assert_equal 5, @visit1.weight
      assert_equal "250 ml", @vacc1.dosage
    end
    
    # test the named scope 'chronological'
    should "list vaccinations in chronological and alphabetical order" do
      assert_equal 5, Vaccination.chronological.size # quick check of size
      dates = Array.new
      # get array of visit dates in order
      [2,3,5,5,6].sort.each {|n| dates << n.months.ago.to_date}
      assert_equal dates, Vaccination.chronological.map{|v| v.visit.date}
    end
    
    # test the named scope 'for_visit'
    should "have named scope for_visit that works" do
      assert_equal 1, Vaccination.for_visit(@visit1.id).size
      assert_equal 2, Vaccination.for_visit(@visit2.id).size
    end
    
    # test the named scope 'for_vaccine'
    should "have named scope called for_visit that works" do
      assert_equal 3, Vaccination.for_vaccine(@leukemia.id).size
      assert_equal 1, Vaccination.for_vaccine(@rabies.id).size
    end
    
    # test the method 'vaccine_matches_animal_type'
    # should "not allow vaccines that are inappropriate to the animal" do
    # end
    
  end
end
