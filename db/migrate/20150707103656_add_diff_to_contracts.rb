class AddDiffToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :diff, :string
  end
end
