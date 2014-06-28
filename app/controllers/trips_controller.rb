class TripsController < ApplicationController
 
  def index
  	@trip=Trip.new
  end
  
  def new
  	@trip=Trip.new
  end
  
  def create
  	@trip=Trip.new(trips_params)
  	if @trip.save
  		msg = { :registration => "successful" }
		render :json => msg 	
    else
    	msg = { :registration => "failed" }
  		render :json => msg
  	end
  end
  
  def matches
  	if params[:id]
  		@trip= Trip.find_by id: params[:id]
  		if !@trip.blank?
  			@lat_src=@trip.lat_src
  			@long_src=@trip.long_src
  			@lat_dest=@trip.lat_dest
  			@long_dest=@trip.long_dest
  			
  			@R=6378137.0
  			@lat_offset=1000.0;
  			@long_offset=1000.0;
  			@lat_displacement = (@lat_offset/@R)
			@long_displacement = @long_offset/(@R*Math.cos(3.14*@lat_src/180))
  			
  			@pos_src_lat=@lat_src + @lat_displacement*180/3.14
  			@neg_src_lat=@lat_src - @lat_displacement*180/3.14
  			@pos_src_long=@long_src + @long_displacement*180/3.14
  			@neg_src_long=@long_src - @long_displacement*180/3.14
  			
  			@long_displacement = @long_offset/(@R*Math.cos(3.14*@lat_dest/180))
  			@pos_dest_lat=@lat_dest + @lat_displacement*180/3.14
  			@neg_dest_lat=@lat_dest - @lat_displacement*180/3.14
  			@pos_dest_long=@long_dest + @long_displacement*180/3.14
  			@neg_dest_long=@long_dest - @long_displacement*180/3.14
  			
  			@trips=Trip.select("trips.*,users.first_name,users.last_name,users.gender, users.dob, users.mobile, users.email").joins("inner join users on user_id=users.id").where("lat_src<=#{@pos_src_lat} and lat_src>=#{@neg_src_lat} and long_src<=#{@pos_src_long} and long_src>=#{@neg_src_long} and lat_dest<=#{@pos_dest_lat} and lat_dest>=#{@neg_dest_lat} and long_dest<=#{@pos_dest_long} and long_dest>=#{@neg_dest_long} and trips.id!=#{@trip.id} and user_id!=#{@trip.user_id}")
  			
  			respond_to do |format|
  					format.html { render 'matches' }
  					format.json  { render :json => @trips }
  				end
  		else
  			respond_to do |format|
  				format.html { render :text => "trips"}
  				msg = { :id => "-1" }
  				format.json  { render :json => msg }
  			end
  		end
  	else
  		render text: "hello"
  	end
  end
  
  def all
  	@trips= Trip.where("user_id = #{params[:user_id]}")
  	respond_to do |format|
  		format.html	{ render 'all' }
  		format.json  { render :json => @trips }
  	end
  end
  
  def show
  	@trip=Trip.where("user_id = #{params[:id]}")
  	respond_to do |format|
  		format.html { render }
  		format.json  { render :json => @trip }
  	end
  end
  
  def edit
  	@trip=Trips.find(params[:id])
  end
  
  def destroy
  
  end
  
  def update
  
  end
  
  private
  def trips_params
  	params.require(:trip).permit(:source,:destination,:lat_src,:long_src,:lat_dest,:long_dest,:departure,:user_id)
  end
  
end
