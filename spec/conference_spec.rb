require_relative 'spec_helper'

describe Conference do
  let(:talks_text) do
    "Writing Fast Tests Against Enterprise Rails 60min
Overdoing it in Python 45min
Lua for the Masses 30min
Ruby Errors from Mismatched Gem Versions 45min
Common Ruby Errors 45min
Rails for Python Developers lightning
Communicating Over Distance 60min
Accounting-Driven Development 45min
Woah 30min
Sit Down and Write 30min
Pair Programming vs Noise 45min
Rails Magic 60min
Ruby on Rails: Why We Should Move On 60min
Clojure Ate Scala (on my project) 45min
Programming in the Boondocks of Seattle 30min
Ruby vs. Clojure for Back-End Development 30min
Ruby on Rails Legacy App Maintenance 60min
A World Without HackerNews 30min
User Interface CSS in Rails Apps 30min"
  end

  let(:few_talks_text) do
    "Writing Fast Tests Against Enterprise Rails 60min
Overdoing it in Python 45min
Lua for the Masses 30min
Ruby Errors from Mismatched Gem Versions 45min
Common Ruby Errors 45min
Rails for Python Developers lightning
"
  end

  let(:result_tracks) do
    "Track 1:
09:00AM Writing Fast Tests Against Enterprise Rails
10:00AM Overdoing it in Python
10:45AM Lua for the Masses
11:15AM Ruby Errors from Mismatched Gem Versions
12:00PM Lunch
01:00PM Common Ruby Errors
01:45PM Rails for Python Developers
01:50PM Communicating Over Distance
02:50PM Accounting-Driven Development
03:35PM Woah
04:05PM Sit Down and Write
04:45PM Networking Event

Track 2:
09:00AM Pair Programming vs Noise
09:45AM Rails Magic
10:45AM Ruby on Rails: Why We Should Move On
12:00PM Lunch
01:00PM Clojure Ate Scala (on my project)
01:45PM Programming in the Boondocks of Seattle
02:15PM Ruby vs. Clojure for Back-End Development
02:45PM Ruby on Rails Legacy App Maintenance
03:45PM A World Without HackerNews
04:15PM User Interface CSS in Rails Apps
04:45PM Networking Event"
  end
let(:conference_instance){Conference.new(talks_text)}
let(:conference_with_few_talks){Conference.new(few_talks_text)}
  describe '#new' do
    context 'with talks text' do
      it "can be created" do
        Conference.new(talks_text)
      end
      it "creates tracks" do
        expect(conference_instance.tracks).to_not be_empty
      end

      it "create 2 tracks" do
        expect(conference_instance.tracks.size).to eq(2)
      end
    end
  end

  describe '#to_output_format' do
    it "returns a string" do
      expect(conference_instance.to_output_format).to be_an(String)
    end
    it "match the expected result" do
      expect(conference_instance.to_output_format.strip).to eq(result_tracks)
    end
  end

  describe '#networking_event_time' do
    context 'with a track with last talk ending at 4:35PM and another ending at 4:45PM' do
      it "returns 04:45PM" do
        expect(conference_instance.networking_event_time).to eq('04:45PM')
      end
    end
    context 'when all talks end before 04:00PM' do
      it "returns 4:00PM" do
        expect(conference_with_few_talks.networking_event_time).to eq('04:00PM')
      end
    end
  end

  describe '::how_many_tracks_for' do
    it "calculate the tracks needed given the amount of time for talks" do
      minutes = 14 * 60 #14 hours in minutes
      expect(Conference.how_many_tracks_for(minutes)).to eq(2)
    end
  end


end
