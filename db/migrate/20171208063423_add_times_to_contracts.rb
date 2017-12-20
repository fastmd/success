class AddTimesToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :sttime, :time
    add_column :contracts, :endtime, :time
    add_column :contracts, :fendtime, :time
  end
end
