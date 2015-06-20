class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :marca
      t.string :gnum
      t.string :cuznum
      t.string :motnum
      t.string :proddate
      t.string :color
      t.string :vmot
      t.string :tmasa
      t.string :tsumm
      
      t.timestamps null: false
    end
  end
end
