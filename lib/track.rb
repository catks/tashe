# coding: utf-8
class Track
  attr_accessor :number, :talks
  attr_reader :morning_talks,:afternoon_talks

  def initialize(number,*talks)
    self.number = number
    self.talks = talks
  end

  def add_talk(talk)
    @talks << talk
  end

  def name
    "Track #{number}"
  end

  def organize_talks(begining_time)
    all_talks = order_by_duration!.dup
    time = begining_time
    number_of_talks = 0

    #morning talks
    while time.hour < 12 && number_of_talks < all_talks.size
      time = begining_time
      time += all_talks.first(number_of_talks).collect{ |talk| talk.duration_in_minutes.to_i}.reduce(:+).to_i * 60
      number_of_talks += 1
    end

    @morning_talks = set_time(all_talks.shift(number_of_talks), begining_time)
    #afternoon talks
    begining_time = Time.new(time.year,time.month,time.day, '13:00')
    time = begining_time
    number_of_talks = 0

    while time.hour < 17 && number_of_talks < all_talks.size
      time = begining_time
      time += all_talks.first(number_of_talks).collect{ |talk| talk.duration_in_minutes.to_i}.reduce(:+).to_i * 60
      number_of_talks += 1
    end

    @afternoon_talks = set_time(all_talks.shift(number_of_talks), begining_time)

  end
  def order_by_duration!(direction = 'asc')
    if direction == 'desc'
      order_by_duration!.reverse
    else
      self.talks.sort_by!{ |talk| talk.duration_in_minutes.to_i }
    end
  end

  private

  def set_time(my_talks,start_time)
    time = start_time
    my_talks.each do |talk|
      talk.start_time = time
      time = talk.end_time
    end
    my_talks
  end
end
