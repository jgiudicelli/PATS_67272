class AddStateToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :state, :string, :default => "PA"
  end
end