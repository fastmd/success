class AddEnddateToContract < ActiveRecord::Migration
  def change
     add_column :contracts, :enddate, :date
  end
end
