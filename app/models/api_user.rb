class ApiUser
  attr_reader :id,
              :name,
              :email

  def initialize(user_params)
    @id    = user_params[:id]
    @name  = user_params[:name]
    @email = user_params[:email]
  end

end
