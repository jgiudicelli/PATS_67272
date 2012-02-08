class CreateVaccines < ActiveRecord::Migration
  def change
    create_table :vaccines do |t|
      t.string :name
      t.integer :animal_id
      t.integer :duration

      t.timestamps
    end
  end
end
