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

end
