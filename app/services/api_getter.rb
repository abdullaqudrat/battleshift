class ApiGetter
  def initialize(path, params = nil)
    @path = path
    @params = params
  end

  def get_response
    conn.get(@path)
  end

  def get_json
   JSON.parse(get_response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: ENV['path']) do |faraday|
      faraday.adapter Faraday.default_adapter
     end
  end
end
