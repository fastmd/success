class AddRefContractsToUsers < ActiveRecord::Migration
  def change
    add_column :contracts, :user_id, :integer
    add_foreign_key :contracts, :users
  end
end
