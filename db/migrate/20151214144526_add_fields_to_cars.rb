class AddFieldsToCars < ActiveRecord::Migration
  def change
    add_column :cars, :aprod, :string
    add_column :cars, :capcil, :string
  end
end
