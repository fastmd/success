class AddBdateToClients < ActiveRecord::Migration
  def change
    add_column :clients, :bdate, :string
  end
end
