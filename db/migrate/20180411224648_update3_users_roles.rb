class Update3UsersRoles < ActiveRecord::Migration
  def up
    execute("
              UPDATE users
              SET user_role = 1
              WHERE username like '%vlad%';")                                                                                                        
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
