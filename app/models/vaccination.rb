class Vaccination < ActiveRecord::Base
  # Relationships
  # -----------------------------
  belongs_to :visit
  belongs_to :vaccine


  # Scopes
  # -----------------------------
  # order by visits in descending order (most recent first)
  scope :chronological, joins(:visit).order('date DESC')
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
  validate :vaccine_offered_by_PATS
  # make sure that the vaccine is appropriate for the animal getting it
  # NOTE: This method must be tested manually in console -- comment it out before running testing suite
  validate :vaccine_matches_animal_type
  
  
  # Use private methods to execute the custom validations
  # -----------------------------
  private
  def vaccine_offered_by_PATS
    # get an array of all vaccine ids this animal can get
    possible_vaccines_ids = Vaccine.all.map{|v| v.id}
    # add error unless the vaccine id is in the array of possible vaccines
    unless possible_vaccines_ids.include?(self.vaccine_id)
      errors.add(:vaccine, "is not available at PATS")
      return false
    end
    return true
  end

  def vaccine_matches_animal_type
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
