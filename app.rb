require_relative 'time_handler'

class App
  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new
    handle_time_request
  end

  private

  def handle_time_request
    @response['Content-Type'] = 'text/plain'
    return not_found_response if @request.path != '/time'
    return no_format_response if @request.params['format'].nil?

    @time = TimeHandler.new(@request.params)
    @time.call(@request.params['format'].split(','))
    perform_format_response
  end

  def not_found_response
    @response.write 'Page not found'
    @response.status = 404
    @response.finish
  end

  def no_format_response
    @response.write 'No time format mentioned'
    @response.status = 400
    @response.finish
  end

  def perform_format_response
    if @time.valid?
      @response.write @time.formatted.to_s
    else
      @response.write "Unknown time format #{@time.unknown_format}"
      @response.status = 400
    end
    @response.finish
  end
end
