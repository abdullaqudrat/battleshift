class UsersController < ApplicationController
  def show
  id = params[:id]
  conn = Faraday.new(url: ENV['path']) do |faraday|
    faraday.adapter Faraday.default_adapter
  end

  response = conn.get("/api/v1/users/1")

  @user = JSON.parse(response.body, symbolize_names: true)
  end
end
