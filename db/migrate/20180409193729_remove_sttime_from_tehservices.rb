class RemoveSttimeFromTehservices < ActiveRecord::Migration
  def change
    remove_column :tehservices, :sttime
  end
end
