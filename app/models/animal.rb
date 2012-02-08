class Animal < ActiveRecord::Base
  # Relationships
  # -----------------------------
  has_many :pets
  has_many :vaccines
  
  # Scopes
  # -----------------------------
  scope :all, order('name')
   
  # Validations
  # -----------------------------
  validates_presence_of :name
  
end
