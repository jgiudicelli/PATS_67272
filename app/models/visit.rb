class Visit < ActiveRecord::Base
  
  # Relationships
  # -----------------------------
  belongs_to :pet
  has_many :vaccinations
  has_many :vaccines, :through => :vaccinations
  has_one :owner, :through => :pet
  
  
  # Scopes
  # -----------------------------
  # by default, order by visits in descending order (most recent first)
   scope :alphabetical, order('visit_date DESC')
   # get all the visits by a particular pet
   scope :for_pet, lambda {|pet_id| where('pet_id = ?', pet_id) }
   # get the last X visits
   scope :last, lambda {|num| limit(num).order('visit_date DESC') }

  
  # Validations
  # -----------------------------
  validates_presence_of :pet_id, :weight, :visit_date
  # weight must be an integer greater than 0 and less than 100 (none of our animal types will exceed)
  validates_numericality_of :weight, :only_integer => true, :greater_than => 0, :less_than => 100
  
end
