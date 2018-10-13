class WelcomeController < ApplicationController
  def index

  end

  def show
    @user = User.find(current_user.id)
    if @user.active == false
      flash[:notice] = "This account has not yet been activated. Please check your email."
    end
  end
end
