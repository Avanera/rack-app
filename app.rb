require_relative 'time_handler'

class App
  def call(env)
    request = Rack::Request.new(env)
    return create_response('Page not found', 404) if request.path != '/time'
    return create_response('No time format mentioned', 400) if request.params['format'].nil?

    time = TimeHandler.new(request.params)
    time.call

    if time.valid?
      create_response(time.formatted.to_s, 200)
    else
      create_response("Unknown time format: #{time.unknown_time_format}", 400)
    end
  end

  def create_response(body, status)
    Rack::Response.new([body], status, { 'Content-Type' => 'text/plain' }).finish
  end
end
