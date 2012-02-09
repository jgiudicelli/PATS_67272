FactoryGirl.define do
  
  factory :animal do
    name "Cat"
  end
  
  factory :vaccine do
    name "Leukemia"
    duration 365
    association :animal
  end
  
  factory :owner do
    first_name "Alex"
    last_name "Heimann"
    street "10152 Sudberry Drive"
    city "Wexford"
    state "PA"
    zip "15090"
    active true
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    email { |a| "#{a.first_name}.#{a.last_name}@example.com".downcase }
  end
  
  factory :pet do
    name "Dusty"
    female true
    active true
    date_of_birth 10.years.ago
    association :owner  # don't have to put the word association in front, but I think it helps...
    association :animal
  end
  
  factory :visit do 
    date 6.months.ago.to_date
    weight 5
    notes "The cat has a lot of hair and sheds often.  Recommend shaving the cat."
    association :pet
  end
  
  factory :vaccination do 
    association :visit
    association :vaccine
    dosage "250 ml"
  end
  
end


# FACTORIES FOR PATS (OLD STYLE, STILL WORKS)
# -------------------------------------------
# # Create factory for Animal class
#   Factory.define :animal do |a|
#     a.name "Cat"
#   end
#   
# # Create factory for Vaccine class
#   Factory.define :vaccine do |v|
#     v.name "Leukemia"
#     v.duration 365
#     v.association :animal
#   end
# 
# # Create factory for Owner class
#   Factory.define :owner do |o|
#     o.first_name "Alex"
#     o.last_name "Heimann"
#     o.street "10152 Sudberry Drive"
#     o.city "Wexford"
#     o.state "PA"
#     o.zip "15090"
#     o.active true
#     o.phone { rand(10 ** 10).to_s.rjust(10,'0') }
#     o.email { |a| "#{a.first_name}.#{a.last_name}@example.com".downcase }
#   end
# 
# # Create factory for Pet class
#   Factory.define :pet do |p|
#     p.name "Dusty"
#     p.female true
#     p.active true
#     p.date_of_birth 10.years.ago
#     p.association :owner
#     p.association :animal
#   end
# 
# # Create factory for Visit class
#   Factory.define :visit do |vi|
#     vi.date 6.months.ago.to_date
#     vi.weight 5
#     vi.notes "The cat has a lot of hair and sheds often.  Recommend shaving the cat."
#     vi.association :pet
#   end
#     
# # Create factory for Vaccination class
#   Factory.define :vaccination do |vn|
#     vn.association :visit
#     vn.association :vaccine
#   end
