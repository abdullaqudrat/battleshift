class UsersController < ApplicationController
  def show
    @response = ApiGetter.new("/api/v1/users/#{params[:id]}").get_json
    @user = ApiUser.new(@response)
  end

end
