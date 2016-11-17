class Talk
  attr_accessor :title, :duration, :start_time
  REGEX_MATCHER = /(.+) (.+)$/
  def initialize(line)
    self.title = line[REGEX_MATCHER,1]
    self.duration = line[REGEX_MATCHER,2]
  end

  def time_duration
    duration_in_minutes.to_i
  end

  def duration_in_minutes
    if duration.match(/lightning/)
      '5min'
    else
      duration
    end
  end

  def end_time
    self.start_time + (time_duration * 60)
  end

  def to_output_format
    "#{format_time(start_time)} #{title}"
  end

  private

  def format_time(time)
    time.strftime('%I:%M%p')
  end
end
