class AddDefaultUser < ActiveRecord::Migration
  def up
    # create a new instance of User and populate
    vet = User.new
    vet.username = "vet"
    vet.email = "vet@example.com"
    vet.password = "yodel"
    vet.password_confirmation = "yodel"
    # save with bang will throw exception on failure
   	vet.save!
  end

  def down
    # find the default user created in the 'up' method
    vet = User.find(:first, :conditions => ["username = ?", "vet"])
    # delete the user when rolling back the migration
    User.delete vet
  end
end
