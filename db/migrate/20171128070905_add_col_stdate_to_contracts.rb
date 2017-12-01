class AddColStdateToContracts < ActiveRecord::Migration
  def change
        add_column :contracts, :stdate, :datetime
  end
end
