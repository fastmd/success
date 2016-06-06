class AddCommentToTehservicesNewest < ActiveRecord::Migration
  
      def change
          add_column :tehservices, :comments, :text
      end
  
end
