class CreateMylogs < ActiveRecord::Migration
  def change
    create_table :mylogs do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
