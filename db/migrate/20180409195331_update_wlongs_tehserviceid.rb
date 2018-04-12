class UpdateWlongsTehserviceid < ActiveRecord::Migration
  def up
    execute("
              UPDATE wlongs
              SET tehservice_id = (SELECT d.id
                               FROM tehservices d
                               WHERE wlongs.wdate = d.sdate and wlongs.car_id = d.car_id
                               )
              WHERE EXISTS (SELECT d.id
                               FROM tehservices d
                               WHERE wlongs.wdate = d.sdate and wlongs.car_id = d.car_id
                               );")                                                                        
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
