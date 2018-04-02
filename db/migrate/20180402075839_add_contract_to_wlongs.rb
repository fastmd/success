class AddContractToWlongs < ActiveRecord::Migration
  def change
    add_reference :wlongs, :contract, index: true, foreign_key: true
  end
end
