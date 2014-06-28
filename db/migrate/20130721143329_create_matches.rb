class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :trip_id
      t.integer :matched_trip_id

      t.timestamps
    end
  end
end
