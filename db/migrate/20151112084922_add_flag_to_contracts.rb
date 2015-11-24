class AddFlagToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :flag, :integer
  end
end
