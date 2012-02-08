class Pet < ActiveRecord::Base

  # Relationships
  # -----------------------------
  belongs_to :owner
  belongs_to :animal
  has_many :visits
  has_many :vaccinations, :through => :visits


  # Scopes
  # -----------------------------
  # order pets by their name
  scope :alphabetical, order('name')
  # get all the pets we treat (not moved away or dead)
  scope :active, where('active = ?', true)
  # get all the female pets
  scope :females, where('female = ?', true)
  # get all the male pets
  scope :males, where('female = ?', false)

  # get all the pets for a particular owner
  scope :for_owner, lambda {|owner_id| where("owner_id = ?", owner_id) }
  # get all the pets who are a particular animal type
  scope :by_animal, lambda {|animal_id| where("animal_id = ?", animal_id) }
  # get all the pets born before a certain date
  scope :born_before, lambda {|dob| where('date_of_birth < ?', dob) }
  # find all pets that have a name like some term or are and animal like some term
  scope :search, lambda { |term| joins(:animal).where('pets.name LIKE ? OR animals.name LIKE ?', "#{term}%", "#{term}%").order("pets.name") }

  # Validations
  # -----------------------------
  # System note:   not requiring DOB because may not be known (e.g., adopted pet)
  # Teaching note: could have done validates_presence_of :name, :animal_id, :owner_id, but 
  #                using a different method discussed in class to show alternative
  #
  # First, make sure a name exists
  validates :name, :presence => true
  # Second, make sure an animal_id is given and is one of the animal types PATS treats
  validates :animal_id, :presence => true
  # validates :animal_id, :inclusion => Animal.all.map{|a| a.id}
  # Third, make sure the owner_id is given and is currently an active owner in the system
  validates :owner_id, :presence => true
  # validates :owner_id, :inclusion => Owner.active.all.map{|o| o.id}


  # Misc Methods and Constants
  # -----------------------------
  # a method to get owner name in last, first format
  def gender
    return "Female" if female
    "Male"
  end  
end
