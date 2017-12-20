class ChangeColTypesToContracts < ActiveRecord::Migration
  def change
    change_column(:contracts, :stdate, :datetime)
    change_column(:contracts, :enddate, :datetime)
    change_column(:contracts, :fenddate, :datetime)
  end
end
