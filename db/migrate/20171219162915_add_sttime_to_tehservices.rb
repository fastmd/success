class AddSttimeToTehservices < ActiveRecord::Migration
  def change
    add_column :tehservices, :sttime, :time
  end
end
