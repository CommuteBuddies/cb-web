class MatchesController < ApplicationController

def choose
  @match=Match.new(match_params)
  
  if @match.save
  		respond_to do |format|
  			format.html { render 'matches' }
  			format.json  { render :json => @match }
  		end
  else
  	respond_to do |format|
  			format.html { render 'matches' }
  			msg = { :id => "-1" }
  			format.json  { render :json => msg }
  		end
  end
end

def show
	@match=Match.where("trip_id=#{params[:trip_id]}")
	respond_to do |format|
  			format.html { render 'show' }
  			format.json  { render :json => @match }
  		end
end 

private
  def match_params
  	params.permit(:trip_id, :matched_trip_id)
  end


end
