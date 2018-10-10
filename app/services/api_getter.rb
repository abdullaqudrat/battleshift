class ApiGetter
  def initialize(path, params = Hash.new(0))
    @path = path
    @params = params
  end

  def get_response
    conn.get(build_path)
  end

  def get_json
   JSON.parse(get_response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: ENV['path'])
  end

  def update_email
    email = @params[:email]
    conn.patch(build_path, body = {email: email})
  end

  def paths
    {user: "/api/v1/users/#{@params[:id]}",
     users: "/api/v1/users"
    }
  end

  def build_path
    paths[@path]
  end

  def parse_json(json)
    JSON.parse(json.body, symbolize_names: true)
  end
end
