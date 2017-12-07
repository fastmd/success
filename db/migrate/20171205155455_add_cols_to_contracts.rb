class AddColsToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :dperiod, :integer
    add_column :contracts, :price, :integer
    add_column :contracts, :curs, :decimal
  end
end
