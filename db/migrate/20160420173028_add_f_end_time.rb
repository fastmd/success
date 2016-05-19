class AddFEndTime < ActiveRecord::Migration
  def change
    add_column :contracts, :fenddate, :date
    add_column :contracts, :fendtime, :time
  end
end
