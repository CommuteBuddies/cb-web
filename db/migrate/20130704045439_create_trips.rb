class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
	  t.string :source
	  t.string :destination
	  t.float :lat_src
	  t.float :long_src
	  t.float :lat_dest
	  t.float :long_dest
	  t.datetime :departure
	  t.integer :user_id	
      t.timestamps
    end
  end
end
