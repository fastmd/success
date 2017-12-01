class ChangeColTypeContracts < ActiveRecord::Migration
  def change
    change_column(:contracts, :stdate, :date)
  end
end
