class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :sname
      t.string :fname
      t.string :address
      t.string :pseria
      t.string :idno
      t.string :dn
      t.string :de
      t.string :tel
      
      t.timestamps null: false
    end
  end
end
