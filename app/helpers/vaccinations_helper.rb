module VaccinationsHelper
  # create a helper to get the options for the visit select menu
  # will return an array with key being date : pet_name so 
  # that vet can choose the right visit
  def get_visit_options
    Visit.all.map{|vi| ["#{vi.date.strftime("%m/%d/%y")} : #{vi.pet.name} (#{vi.pet.animal.name})", vi.id] }
  end
  
  # create a helper to get the options for the vaccine select menu
  # need to include both vaccine name and animal it's for since 
  # many animals have rabies vaccines (for example), but the 
  # rabies vaccine for dogs may be harmful to cats -- need to 
  # know which vaccine for what animal type is being given.
  def get_vaccine_options
    Vaccine.all.map{|vac| ["#{vac.name} : #{vac.animal.name}", vac.id] }
  end
end
