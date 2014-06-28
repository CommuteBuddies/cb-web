class ChangeTripsColumns < ActiveRecord::Migration
  def change
  	change_table :trips do |t|
  		t.change :lat_src, :decimal,:precision=>30, :scale=>24
  		t.change :long_src, :decimal,:precision=>30, :scale=>24
  		t.change :lat_dest, :decimal,:precision=>30, :scale=>24
  		t.change :long_dest, :decimal,:precision=>30, :scale=>24
  	end
  end
end
