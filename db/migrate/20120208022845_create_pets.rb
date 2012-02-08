class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.integer :animal_id
      t.integer :owner_id
      t.string :name
      t.boolean :female
      t.date :date_of_birth
      t.boolean :active

      t.timestamps
    end
  end
end
