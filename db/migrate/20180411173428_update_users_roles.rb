class UpdateUsersRoles < ActiveRecord::Migration
  def up
    execute("
              UPDATE users
              SET superadmin_role = 1
              WHERE username='larisa' or username='octa' ;")                                                                                                        
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
