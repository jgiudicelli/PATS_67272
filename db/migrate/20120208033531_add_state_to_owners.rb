class AddStateToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :state, :string
  end
end