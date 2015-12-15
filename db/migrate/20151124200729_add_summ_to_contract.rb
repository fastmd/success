class AddSummToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :summ, :string
    add_column :contracts, :zalog, :string
  end
end
