class RemoveColsFromContracts < ActiveRecord::Migration
  def change
    remove_column :contracts, :sttime
    remove_column :contracts, :endtime
    remove_column :contracts, :fendtime
  end
end
