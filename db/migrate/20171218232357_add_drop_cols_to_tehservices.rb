class AddDropColsToTehservices < ActiveRecord::Migration
  def change
    add_reference :tehservices, :user, foreign_key: true
    remove_foreign_key :wlongs, :tehservice
    remove_reference :wlongs, :tehservice
    remove_column :tehservices, :manager, :string
    change_column :tehservices, :stype, :integer
  end
end
