class AddCommentToCparams < ActiveRecord::Migration
  def change
    add_column :cparams, :comment, :text
  end
end
