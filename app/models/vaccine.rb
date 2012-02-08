class Vaccine < ActiveRecord::Base
  
  # callback to allow for a 'lifetime' vaccine (if no duration set)
  before_save :check_vaccine_duration
  
  # Relationships
  # -----------------------------
  belongs_to :animal
  has_many :vaccinations
  has_many :visits, :through => :vaccinations
  
  # Scopes
  # -----------------------------
  scope :alphabetical, order('name')
  # get all the vaccines this type of animal can have
  scope :for_animal, lambda {|animal_id| where('animal_id = ?', animal_id) }
  
  # Validations
  # -----------------------------
  validates_presence_of :name, :animal_id
  # duration must be an integer greater than 0 (or blank if lifetime vaccine)
  validates_numericality_of :duration, :only_integer => true, :greater_than => 0, :allow_blank => true, :allow_nil => true
  
  # Callback code
  # -----------------------------
  private
    # If a duration is not set, assume that it's a 'lifetime' vaccine.
    def check_vaccine_duration
       dur = self.duration
       # if the duration not set, assume a 'lifetime' vaccine good for 20 yrs
       self.duration = 7300 if dur.nil? || dur.blank?
    end
  
end
