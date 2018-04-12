class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :superadmin_role, :boolean, default: false
    add_column :users, :supervisor_role, :boolean, default: false
    add_column :users, :user_role, :boolean, default: false
    add_column :users, :nemo_role, :boolean, default: true
  end
end
