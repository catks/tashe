# coding: utf-8
class Track
  START_TIME = '9:00'.freeze
  LUNCH_TIME = '12:00'.freeze
  AFTERNOON_START_TIME = '13:00'.freeze
  MAX_END_TIME = '17:00'.freeze

  attr_accessor :number

  def initialize(number,*talks)
    self.number = number
    talks.each do |talk|
      add_talk talk
    end
  end

  def add_talk(talk)
    talk.start_time = first_time_avaible_in_morning
    if can_be_added_in_morning?(talk)
      @morning_talks ||= []
      @morning_talks << talk
      return true
    end

    talk.start_time = first_time_avaible_in_afternoon
    if can_be_added_in_afternoon?(talk)
      @afternoon_talks ||= []
      @afternoon_talks << talk
      return true
    end
  end

  def name
    "Track #{number}"
  end

  def talks
    @talks = @morning_talks.to_a + @afternoon_talks.to_a
  end

  def morning_talks
    @morning_talks || []
  end

  def afternoon_talks
    @afternoon_talks || []
  end


  def can_be_added_in_morning?(talk)
    return true if @morning_talks.nil?
    talk.time_duration <= remaning_time_in_morning
  end

  def remaning_time_in_morning
    last_time = @morning_talks ? @morning_talks.last.end_time : Track.beginning_time
    (Track.lunch_time - last_time) / 60 #transform in minutes
  end

  def can_be_added_in_afternoon?(talk)
    return true if @afternoon_talks.nil?
    talk.time_duration <= remaning_time_in_afternoon
  end

  def can_be_added?(talk)
    can_be_added_in_morning?(talk) || can_be_added_in_afternoon?(talk)
  end

  def remaning_time_in_afternoon
    last_time = @afternoon_talks ? @afternoon_talks.last.end_time : Track.afternoon_begin_time
    (Track.max_end_time - last_time) / 60 #transform in minutes
  end


  def self.beginning_time
    t = Time.now
    Time.new(t.year, t.month, t.day, START_TIME)
  end

  def self.afternoon_begin_time
    t = Time.now
    Time.new(t.year, t.month, t.day, AFTERNOON_START_TIME)
  end

  def self.lunch_time
    t = Time.now
    Time.new(t.year, t.month, t.day, LUNCH_TIME)
  end

  def self.max_end_time
    t = Time.now
    Time.new(t.year, t.month, t.day, MAX_END_TIME)
  end

  def self.time_in_minutes
    t = Track.new(1)
    t.remaning_time_in_morning + t.remaning_time_in_afternoon
  end

  def first_time_avaible_in_morning
    if morning_talks.empty?
      Track.beginning_time
    else
      @morning_talks.last.end_time
    end
  end

  def first_time_avaible_in_afternoon
    if afternoon_talks.empty?
      Track.afternoon_begin_time
    else
      afternoon_talks.last.end_time
    end
  end

  def to_output_format
    "Track #{self.number}:\n" +
    @morning_talks.map(&:to_output_format).reduce(""){ |memo,val| memo + val + "\n" } +
    "#{LUNCH_TIME}PM Lunch\n" +
    @afternoon_talks.map(&:to_output_format).reduce(""){ |memo,val| memo + val + "\n" } +
    "#{afternoon_talks.last.end_time.strftime('%I:%M%p')} Networking Event\n"
  end
end
