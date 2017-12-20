class ChangeWlongTypeWlongs < ActiveRecord::Migration
  def change
      change_column(:wlongs, :wlong, :integer)
  end
end
