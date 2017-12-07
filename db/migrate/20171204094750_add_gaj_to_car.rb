class AddGajToCar < ActiveRecord::Migration
  def change
    add_column :cars, :gaj, :integer
    change_column(:cars, :int1price, :integer)
    change_column(:cars, :int2price, :integer)
    change_column(:cars, :int3price, :integer)
    change_column(:cars, :int4price, :integer)
    change_column(:cars, :int5price, :integer)
    change_column(:cars, :int6price, :integer)
    change_column(:cars, :int7price, :integer)
  end
end
