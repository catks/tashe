require_relative 'spec_helper'

describe Track do
  let(:track_instance){Track.new(1)}
  let(:track_instance_with_talks) do
    track_instance.add_talk(Talk.new("Okay Talk lighting"))
    track_instance.add_talk(Talk.new("Awesome Talk 10min"))
    track_instance
  end
  describe 'attributes' do
    describe 'number' do
      it "can be created with number" do
        expect(Track.new(3).number).to eq(3)
      end
      it "can be seted" do
        track_instance.number = 2
      end
      it "return the track number" do
        expect(track_instance.number).to be_an(Fixnum)
      end
    end
  end

  describe '#add_new_talk' do
    it "add a new talk" do
      expect{track_instance.add_talk(Talk.new('Some Talk 12min'))}
        .to change{track_instance.talks.size}.by(1)
    end
  end

  describe '#talks' do
    context 'when talks are added' do
      it "returns all the talks" do
        expect(track_instance_with_talks.talks).to all(be_an(Talk))
      end
      it "is not empty" do
        expect(track_instance_with_talks.talks).to_not be_empty
      end
    end
  end

  describe '#name' do
    it "returns 'Track {id}'" do
      expect(track_instance.name).to eq "Track #{track_instance.number}"
    end
  end

  describe '#order_by_duration!' do
    it "order by the duration" do
      expect(track_instance_with_talks.order_by_duration!).to eq track_instance_with_talks.talks.sort_by{ |talk| talk.duration_in_minutes.to_i }
    end
    context 'with "desc"' do
      it "order by the duration fot the bigger to the small" do
        expect(track_instance_with_talks.order_by_duration!("desc")).to eq track_instance_with_talks.talks.sort_by{ |talk| talk.duration_in_minutes.to_i }.reverse
      end
    end

    context 'with asc' do
      it "order by the duration for the small to the bigger" do
        expect(track_instance_with_talks.order_by_duration!("asc")).to eq track_instance_with_talks.talks.sort_by{ |talk| talk.duration_in_minutes.to_i }
      end
    end
  end

  describe 'morning_talks' do
    before(:each){track_instance_with_talks.organize_talks(Time.new(2016,12,1,'9:00'))}
    it "returns the morning talks" do
      expect(track_instance_with_talks.morning_talks).to all(be_an(Talk))
    end

    it "not empty" do
      expect(track_instance_with_talks.morning_talks).to_not be_empty
    end

    it "begins at 9am" do
      expect(track_instance_with_talks.morning_talks.first.start_time.hour).to eq(9)
    end

    it "don't pass 12" do
      expect(track_instance_with_talks.morning_talks.last.end_time.hour)
        .to be <= 12
      if track_instance_with_talks.morning_talks.last.end_time.hour == 12
        expect(track_instance_with_talks.morning_talks.last.min).to eq(0)
      end
    end
  end
end
