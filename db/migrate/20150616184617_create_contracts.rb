class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :cnum
      t.datetime :order_date
      t.belongs_to :car, index: true
      t.belongs_to :client, index: true
      t.timestamps null: false
    end
  end
end
