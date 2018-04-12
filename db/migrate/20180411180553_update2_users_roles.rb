class Update2UsersRoles < ActiveRecord::Migration
  def up
    execute("
              UPDATE users
              SET supervisor_role = 1
              WHERE username like '%zzz%';")                                                                                                        
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
