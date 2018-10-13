class UsersController < ApplicationController
require 'securerandom'

  def show
    @response = UserApiInterface.new(:user, params).get_json
    @user = User.new(@response)
  end

  def index
    @response = UserApiInterface.new(:users).get_json
    @users = @response.map do |user_response|
      User.new(user_response)
    end
  end

  def edit
    @user = params[:id]
  end

  def update
    api_interface    = UserApiInterface.new(:user, params)
    raw_user         = api_interface.update_email
    parsed_user      = api_interface.parse_json(raw_user)
    flash[:notice] = "Successfully updated #{parsed_user[:name]}"
    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      @user.update(api_key: SecureRandom.urlsafe_base64)
      session[:user_id] = @user.id.to_s
    	UserMailer.activate(@user).deliver_now
      redirect_to '/dashboard'
    else
      render :new
      flash[:notice] = "Failed to Create User"
    end
  end

	def activate
		@user = User.find(params[:id])
		if @user.api_key == params[:key]
			@user.update( active: true)
    	flash[:notice] = "Thank you! Your account is now activated."
		else
    	flash[:notice] = "Wrong User Token"
		end
			redirect_to '/dashboard'
	end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
