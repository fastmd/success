class RemCol < ActiveRecord::Migration
  def change
    remove_column :tehservices, :wlong
  end
end
