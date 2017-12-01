class AddIndexContractsToUsers < ActiveRecord::Migration
  def change
    remove_column :contracts, :user, :string
    add_index :contracts, :user_id
  end
end
