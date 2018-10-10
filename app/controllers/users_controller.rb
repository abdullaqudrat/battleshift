class UsersController < ApplicationController
  def show

    @response = ApiGetter.new("/api/v1/users/#{params[:id]}").get_json
    @user = ApiUser.new(@response)
  end

  def index
    @response = ApiGetter.new("/api/v1/users").get_json

    @users = @response.map do |user_response|
      ApiUser.new(user_response)
    end
  end

  def edit
    @user = params[:id]
    @response = ApiGetter.new("/api/v1/users/#{params[:id]}").get_json
    @user = ApiUser.new(@response)
  end

  def update
    @response = ApiGetter.new("/api/v1/users/#{params[:id]}", params)
    @data = @response.get_json
    @response.update
    @user = ApiUser.new(@data)
    flash[:notice] = "Successfully updated #{@user.name}"
    redirect_to '/users'

  end
end
