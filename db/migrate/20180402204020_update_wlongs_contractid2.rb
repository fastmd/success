class UpdateWlongsContractid2 < ActiveRecord::Migration
  def up
    execute("
              UPDATE wlongs
              SET contract_id = (SELECT d.id
                               FROM contracts d
                               WHERE wlongs.wdate = d.fenddate and wlongs.car_id = d.car_id
                               )
              WHERE EXISTS (SELECT d.id
                               FROM contracts d
                               WHERE wlongs.wdate = d.fenddate and wlongs.car_id = d.car_id
                               );")                                                                        
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
