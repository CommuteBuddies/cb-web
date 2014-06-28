class Match < ActiveRecord::Base
	validates :matched_trip_id, uniqueness: { scope: :trip_id,
    message: "One matched trip per trip id" }
    
    belongs_to :trip
end
