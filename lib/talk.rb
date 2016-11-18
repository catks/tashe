class Talk
  attr_accessor :title, :duration, :start_time
  REGEX_MATCHER = /(.+) (.+)$/
  def initialize(line)
    title = line[REGEX_MATCHER,1]
    duration = line[REGEX_MATCHER,2]
    raise "Invalid title '#{title}'" unless title_valid?(title)
    raise "Invalid duration '#{title}'" unless duration_valid?(duration)
    self.title = title
    self.duration = duration
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

  def title_valid?(title)
    !title.match(/\d/) && title.match(/\w+/)
  end

  def duration_valid?(duration)
    !!duration.match(/(\d+min|lightning)$/)
  end
end
