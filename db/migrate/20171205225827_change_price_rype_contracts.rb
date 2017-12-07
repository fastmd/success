class ChangePriceRypeContracts < ActiveRecord::Migration
  def change
    change_column(:contracts, :price, :decimal)
  end
end
