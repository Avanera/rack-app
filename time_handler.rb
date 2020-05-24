class TimeHandler

  attr_reader :valid, :unknown

  FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d',
              'hour' => '%H', 'minute' => '%m', 'second' => '%S' }.freeze
  
  def initialize(params)
    @valid = ''
    @unknown = []
    call(params['format'].split(','))
  end

  def call(params)
    params.each do |format|
      if FORMATS[format]
        @valid += (' ' + FORMATS[format])
      else
        @unknown << format
      end
    end
  end
end
