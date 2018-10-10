class UsersController < ApplicationController
  def show
    @response = ApiGetter.new(:user, params).get_json
    @user = ApiUser.new(@response)
  end

  def index
    @response = ApiGetter.new(:users).get_json
    @users = @response.map do |user_response|
      ApiUser.new(user_response)
    end
  end

  def edit
    @user = params[:id]
  end

  def update
    api_interface    = ApiGetter.new(:user, params)
    raw_user         = api_interface.update_email
    parsed_user      = api_interface.parse_json(raw_user)
    flash[:notice] = "Successfully updated #{parsed_user[:name]}"
    redirect_to users_path
  end
end
