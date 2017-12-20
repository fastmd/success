class ChangeColsTehservices < ActiveRecord::Migration
  def change
    change_column :tehservices, :sprice, :decimal, :precision => 2
    add_index :tehservices, :user_id
    remove_column :wlongs, :manager, :string
  end
end
