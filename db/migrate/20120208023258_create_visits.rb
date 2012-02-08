class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :pet_id
      t.date :date
      t.integer :weight
      t.text :notes

      t.timestamps
    end
  end
end
