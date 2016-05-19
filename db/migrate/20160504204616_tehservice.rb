class Tehservice < ActiveRecord::Migration
  def change
    create_table :tehservices do |t|
      t.string :stype
      t.string :manager
      t.integer :wlong
      t.string :sprice
      t.datetime :sdate
      t.belongs_to :car, index: true
      t.timestamps null: false
    end
  end
end
