class Conference
  attr_reader :talks,:tracks

  def initialize(talks_text)
    @talks = []
    talks_text.each_line do |line|
      @talks << Talk.new(line)
    end
    minutes = @talks.map(&:time_duration).reduce(:+)
    @tracks = Conference.how_many_tracks_for(minutes).times.map{ |i| Track.new(i + 1)}

    all_talks = @talks.dup

    all_talks.each do |talk|
      @tracks.each do |track|
        if track.can_be_added?(talk)
          track.add_talk(talk)
          break
        end
      end
    end
  end

  def to_output_format
    result = ""
    @tracks.each do |track|
      result << track.to_output_format + "\n"
    end
    result
  end

  def self.how_many_tracks_for(minutes)
    (minutes.to_f / Track.time_in_minutes).ceil
  end
end
