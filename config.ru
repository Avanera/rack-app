require_relative 'middleware/logger'
require_relative 'app'

use Rack::Reloader
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
run App.new
