require_relative 'time_handler'

class App
  def call(env)
    request = Rack::Request.new(env)
    path = request.path
    time = TimeHandler.new(request.params)
    
    if path != '/time'
      return response(404, "Page not found")
    end

    if time.unknown.empty?
      response(200, Time.now.strftime(time.valid))
    else
      response(400, "Unknown time format #{time.unknown}")
    end
  end
  
  private
  
  def response(status, body)
    [
      status,
      {'Content-Type' => 'text/plain'},
      [body]
    ]
  end
end
