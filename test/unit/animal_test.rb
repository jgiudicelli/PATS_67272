require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
  # Not much for testing Animal as it is a simple model
  # Relationship macros...
  should have_many(:pets)
  should have_many(:vaccines)
  
  # Validation macros...
  should validate_presence_of(:name)
end
