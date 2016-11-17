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

  let(:result_tracks) do
"Track 1:
09:00AM Writing Fast Tests Against Enterprise Rails
10:00AM Overdoing it in Python
10:45AM Lua for the Masses
11:15AM Ruby Errors from Mismatched Gem Versions
12:00PM Rails for Python Developers
12:00PM Lunch
01:00PM Common Ruby Errors
01:45PM Communicating Over Distance
02:45PM Accounting-Driven Development
03:30PM Woah
04:00PM Sit Down and Write
04:30PM Programming in the Boondocks of Seattle
05:00PM Networking Event

Track 2:
09:00AM Pair Programming vs Noise
09:45AM Rails Magic
10:45AM Ruby on Rails: Why We Should Move On
12:00PM Lunch
01:00PM Clojure Ate Scala (on my project)
01:45PM Ruby vs. Clojure for Back-End Development
02:15PM Ruby on Rails Legacy App Maintenance
03:15PM A World Without HackerNews
03:45PM User Interface CSS in Rails Apps
04:15PM Networking Event"
  end
let(:conference_instance){Conference.new(talks_text)}

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
  describe '::how_many_tracks_for' do
    it "calculate the tracks needed given the amount of time for talks" do
      minutes = 14 * 60 #14 hours in minutes
      expect(Conference.how_many_tracks_for(minutes)).to eq(2)
    end
  end
end