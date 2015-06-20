class AddUserToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :user, :string
  end
end
