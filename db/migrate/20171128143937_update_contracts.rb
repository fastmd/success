class UpdateContracts < ActiveRecord::Migration
  def up
    execute("UPDATE contracts SET stdate=order_date, enddate=date(order_date, '+1 day');")                                                 
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
