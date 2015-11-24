class AddPemailToClients < ActiveRecord::Migration
  def change
    add_column :clients, :pemail, :string
  end
end
