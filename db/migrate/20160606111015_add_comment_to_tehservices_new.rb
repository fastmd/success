class AddCommentToTehservicesNew < ActiveRecord::Migration
  def change
    add_column :tehservices, :comments, :text
  end
end
