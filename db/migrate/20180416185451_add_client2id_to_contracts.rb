class AddClient2idToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :client2_id, :integer
    add_foreign_key :contracts, :clients, column: :client2_id
    add_index :contracts, :client2_id
  end
end
