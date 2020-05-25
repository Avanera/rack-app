class TimeHandler

  attr_reader :unknown_format

  FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d',
              'hour' => '%H', 'minute' => '%m', 'second' => '%S' }.freeze
  
  def initialize(params)
    @valid_format = ''
    @unknown_format = []
  end

  def call(params)
    params.each do |format|
      if FORMATS[format]
        @valid_format += (' ' + FORMATS[format])
      else
        @unknown_format << format
      end
    end
  end

  def valid?
    @unknown_format.empty?
  end

  def formatted
    Time.now.strftime(@valid_format)
  end
end
