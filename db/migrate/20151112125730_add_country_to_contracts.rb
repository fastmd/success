class AddCountryToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :country, :string
  end
end
