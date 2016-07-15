class CreateCparams < ActiveRecord::Migration
  def change
    create_table :cparams do |t|
      t.float :curs
      t.time :mdt

      t.timestamps null: false
    end
  end
end
