class CreateVaccinations < ActiveRecord::Migration
  def change
    create_table :vaccinations do |t|
      t.integer :vaccine_id
      t.integer :visit_id
      t.string :dosage

      t.timestamps
    end
  end
end
