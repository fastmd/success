class UpdateWlongsContractid < ActiveRecord::Migration
  def up
    execute("
              SELECT wlongs.id, wlongs.parcurs, wlongs.wdate, wlongs.car_id, wlongs.created_at, wlongs.updated_at, contracts.car_id, wlongs.tehservice_id      
              FROM wlongs 
              JOIN contracts ON contracts.car_id = wlongs.car_id and contracts.stdate = wlongs.wdate;")                                       
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
