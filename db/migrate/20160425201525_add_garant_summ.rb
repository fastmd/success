class AddGarantSumm < ActiveRecord::Migration
  def change
    add_column :contracts, :garant_summ, :string
  end
end
