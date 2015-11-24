class Crwaylong < ActiveRecord::Migration
  def change
    create_table :wlongs do |t|
      t.string :wlong
      t.string :manager
      t.datetime :wdate
      t.belongs_to :car, index: true
      t.timestamps null: false
    end
  end
end
