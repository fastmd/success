class AddPlaceToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :place, :integer
  end
end
