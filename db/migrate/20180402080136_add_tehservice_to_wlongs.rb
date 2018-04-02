class AddTehserviceToWlongs < ActiveRecord::Migration
  def change
    add_reference :wlongs, :tehservice, index: true, foreign_key: true
  end
end
