class AddCostleiToContract < ActiveRecord::Migration
  def change
          add_column :contracts, :costlei, :float
  end
end
