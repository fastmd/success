class AddMultitarifToCars < ActiveRecord::Migration
  def change
    add_column :cars, :int1, :integer
    add_column :cars, :int1price, :float
    add_column :cars, :int2, :integer
    add_column :cars, :int2price, :float
    add_column :cars, :int3, :integer
    add_column :cars, :int3price, :float
    add_column :cars, :int4, :integer
    add_column :cars, :int4price, :float
    add_column :cars, :int5, :integer
    add_column :cars, :int5price, :float
    add_column :cars, :int6, :integer
    add_column :cars, :int6price, :float
    add_column :cars, :int7, :integer
    add_column :cars, :int7price, :float
  end
end
