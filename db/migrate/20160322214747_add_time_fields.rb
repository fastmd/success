class AddTimeFields < ActiveRecord::Migration
  def change
    add_column :contracts, :sttime, :time
    add_column :contracts, :endtime, :time
  end
end
