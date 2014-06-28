class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index	
  end
  
  def login
  	if params[:login]
  		@user= Users.find_by mobile: params[:username]
  		if !@user.blank? && @user.password == params[:password]
  			respond_to do |format|
  				format.html { redirect_to user_trips_path(@user.id) }
  				format.json  { render :json => @user }
  			end
  		else
  			respond_to do |format|
  				format.html { redirect_to action: 'index'}
  				msg = { :id => "-1" }
  				format.json  { render :json => msg }
  			end
  		end
  	elsif params[:sign_up]  
  		redirect_to action: 'new'
  	end
  end
  
  def new
  	@user= Users.new
  end
  
  def create
    @user = Users.new(user_params)
    if @user.save
    	msg = { :registration => "successful" }
		render :json => msg 
		UserMailer.welcome_email(@user).deliver	
    else
    	msg = { :registration => "failed" }
  		render :json => msg
    end
   
  end
  
  private
  def user_params
      params.require(:users).permit(:first_name, :last_name, :gender, :dob, :mobile, :email,:password)
    end
  
end
