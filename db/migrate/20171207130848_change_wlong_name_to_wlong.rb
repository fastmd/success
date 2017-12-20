class ChangeWlongNameToWlong < ActiveRecord::Migration
  def change
    rename_column :wlongs, :wlong, :parcurs
  end
end
