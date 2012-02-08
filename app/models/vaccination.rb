class Vaccination < ActiveRecord::Base
  # Relationships
  # -----------------------------
  belongs_to :visit
  belongs_to :vaccine


  # Scopes
  # -----------------------------
  # by default, order by visits in descending order (most recent first)
  scope :all, joins(:visit).order('date DESC')
  # get all the vaccinations that adminstered a particular vaccine
  scope :for_vaccine, lambda {|vaccine_id| where("vaccine_id = ?", vaccine_id) }
  # get all the vaccinations given on a particular visit
  scope :for_visit, lambda {|visit_id| where("visit_id = ?", visit_id) }
  # get the last X number of vaccinations
  scope :last, lambda {|num| limit(num) }

  
  # Validations
  # -----------------------------
  validates_presence_of :vaccine_id, :visit_id
  # make sure the vaccine selected is one that is offered by PATS
  validates_inclusion_of :vaccine_id, :in => Vaccine.all.map{|v| v.id}, :message => "is not available at PATS"
  # validates_inclusion_of :vaccine_id, :in => (1..54).to_a, :message => "is not available at PATS"

  # make sure that the vaccine is appropriate for the animal getting it
  # needs to be commented out for unit tests because it doesn't play nice
  # with factory_girl
  validate :vaccine_matches_animal_type?

  private
  # NOTE: this method is tested in both console and in a browser and it works.
  # However, it does not play nicely with unit testing and needs to be commented 
  # out before testing.  (Actually, just comment out the validate method that 
  # calls it.)
  def vaccine_matches_animal_type?
    # find the animal type for the visit in question
    animal = Visit.find(self.visit_id).pet.animal
    # get an array of all vaccine ids this animal can get
    possible_vaccines_ids = Vaccine.for_animal(animal.id).map{|v| v.id}
    # add error unless the vaccine id is in the array of possible vaccines
    unless possible_vaccines_ids.include?(self.vaccine_id)
      errors.add(:vaccine, "is inappropriate for this animal")
      return false
    end
    return true
  end

end
