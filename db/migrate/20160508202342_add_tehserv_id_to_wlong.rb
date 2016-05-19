class AddTehservIdToWlong < ActiveRecord::Migration
  
    def change
          add_column :wlongs, :tehservice_id, :integer, references: :tehservices
      end
  
end
