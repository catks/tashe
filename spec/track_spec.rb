require_relative 'spec_helper'

describe Track do
  let(:track_instance){Track.new(1)}
  let(:track_instance_with_talks) do
    track_instance.add_talk(Talk.new("Okay Talk lighting"))
    track_instance.add_talk(Talk.new("Awesome Talk 10min"))
    track_instance
  end

  let(:track_instance_with_full_morning) do
    track_instance.add_talk(Talk.new("Okay Talk 60min"))
    track_instance.add_talk(Talk.new("Sad Talk 60min"))
    track_instance.add_talk(Talk.new("Bum Talk 60min"))
    track_instance
  end

  let(:track_instance_with_full_time) do
    track_instance_with_full_morning.add_talk(Talk.new("Okay Talk 60min"))
    track_instance_with_full_morning.add_talk(Talk.new("Okay Talk 60min"))
    track_instance_with_full_morning.add_talk(Talk.new("Okay Talk 60min"))
    track_instance_with_full_morning.add_talk(Talk.new("Okay Talk 60min"))
    track_instance_with_full_morning
  end

  let(:sample_talk){Talk.new('Okay talk 10min')}
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

  describe "#time_in_minutes" do
    it "returns the max time in minutes that a Track can have" do
      minutes = 7 * 60 #& hours in minutes
      expect(Track.time_in_minutes).to eq(minutes)
    end
  end
  describe "::beginning_time" do
    it "returns a time starting at 9:00am" do
      expect(Track.beginning_time.hour).to eq(9)
      expect(Track.beginning_time.min).to eq(0)
    end
  end

  describe "::lunch_time" do
    it "returns a time starting at 12:00am" do
      expect(Track.lunch_time.hour).to eq(12)
      expect(Track.lunch_time.min).to eq(0)
    end
  end

  describe "::afternoon_begin_time" do
    it "returns a time starting at 13:00am" do
      expect(Track.afternoon_begin_time.hour).to eq(13)
      expect(Track.afternoon_begin_time.min).to eq(0)
    end
  end

  describe "::max_end_time" do
    it "returns a time of 17:00am" do
      expect(Track.max_end_time.hour).to eq(17)
      expect(Track.max_end_time.min).to eq(0)
    end
  end

  describe "#remaning_time_in_morning" do
    context "when no talk was added" do
      it "returns the 3 hours" do
        expect(track_instance.remaning_time_in_morning).to eq(3 * 60) # 3 hours in minutes
      end
    end

    context "when a talk of 45 minutes is added" do
      before(:each){ track_instance.add_talk(Talk.new("Some cool talk 45min"))}
      it "returns the 2 hours and 15 minutes" do
        expect(track_instance.remaning_time_in_morning).to eq((2 + 15.0 / 60) * 60) # 2 hours and 5 minutes in minutes
      end
    end

    context "when morning talks are full" do
      before(:each){ track_instance.add_talk(Talk.new("Some cool talk 180min"))}
      it "returns 0 minutes" do
        expect(track_instance.remaning_time_in_morning).to eq(0)
      end
    end
  end

  describe "#remaning_time_in_afternoon" do
    context "when no talk was added" do
      it "returns the 4 hours" do
        expect(track_instance.remaning_time_in_afternoon).to eq(4 * 60) # 4 hours in minutes
      end
    end

    context "when a talk of 45 minutes is added" do
      before(:each){ track_instance_with_full_morning.add_talk(Talk.new("Some cool talk 45min"))}
      it "returns the 3 hours and 15 minutes" do
        expect(track_instance_with_full_morning.remaning_time_in_afternoon).to eq((3 + 15.0 / 60) * 60) # 3 hours and 5 minutes in minutes
      end
    end

    context "when afternoon talks are full" do
      before(:each){ track_instance_with_full_morning.add_talk(Talk.new("Some cool talk 240min"))}
      it "returns 0 minutes" do
        expect(track_instance.remaning_time_in_afternoon).to eq(0)
      end
    end
  end

  describe '#can_be_added_in_morning?' do
    context "when a talk of 170 minutes is added" do
      before(:each){ track_instance.add_talk(Talk.new("Some cool talk 170min"))}
      it "can add a talk of 10min" do
        expect(track_instance.can_be_added_in_morning?(Talk.new("Fast Talk 10min"))).to be true
      end
      it "can't add a talk of 11min" do
        expect(track_instance.can_be_added_in_morning?(Talk.new("Fast Talk 11min"))).to be false
      end
    end
  end

  describe '#can_be_added_in_afternoon?' do
    context "when a talk of 230 minutes is added" do
      before(:each){ track_instance_with_full_morning.add_talk(Talk.new("Some cool talk 230min"))}
      it "can add a talk of 10min" do
        expect(track_instance_with_full_morning.can_be_added_in_afternoon?(Talk.new("Fast Talk 10min"))).to be true
      end
      it "can't add a talk of 11min" do
        expect(track_instance_with_full_morning.can_be_added_in_afternoon?(Talk.new("Fast Talk 11min"))).to be false
      end
    end
  end

  describe 'can_be_added?' do
    context 'when track is empty' do
      it "returns true" do
        expect(track_instance.can_be_added?(sample_talk)).to be true
      end
    end
    context 'when track is full in morning but empty in afternoon' do
      it "returns true" do
        expect(track_instance_with_full_morning.can_be_added?(sample_talk)).to be true
      end
    end
    context 'when track is full' do
      it "returns true" do
        expect(track_instance_with_full_time.can_be_added?(sample_talk)).to be false
      end
    end

  end

  describe '#first_time_avaible_in_morning' do
    context 'when no talk is added' do
      it "returns 9:00" do
        expect(track_instance.first_time_avaible_in_morning.hour).to eq(9)
        expect(track_instance.first_time_avaible_in_morning.min).to eq(0)
      end
    end
    context 'when a talk of 15 minutes is added' do
      before(:each){track_instance.add_talk(Talk.new('Zzzzz 15min'))}
      it "returns 9:15" do
        expect(track_instance.first_time_avaible_in_morning.hour).to eq(9)
        expect(track_instance.first_time_avaible_in_morning.min).to eq(15)
      end
    end
  end

  describe '#first_time_avaible_in_afternoon' do
    context 'when no talk is added in afternoon' do
      it "returns 13:00" do
        expect(track_instance_with_full_morning.first_time_avaible_in_afternoon.hour).to eq(13)
        expect(track_instance_with_full_morning.first_time_avaible_in_afternoon.min).to eq(0)
      end
    end
    context 'when a talk of 15 minutes is added' do
      before(:each){track_instance_with_full_morning.add_talk(Talk.new('Zzzzz 15min'))}
      it "returns 13:15" do
        expect(track_instance_with_full_morning.first_time_avaible_in_afternoon.hour).to eq(13)
        expect(track_instance_with_full_morning.first_time_avaible_in_afternoon.min).to eq(15)
      end
    end
  end

  describe '#add_new_talk' do
    context 'with a empty track' do
      it "add a new talk" do
        expect{track_instance.add_talk(Talk.new('Some Talk 12min'))}
          .to change{track_instance.talks.size}.by(1)
      end

      it "add to morning_talks" do
        expect{track_instance.add_talk(Talk.new('Some Talk 12min'))}
          .to change{track_instance.morning_talks.size}
      end
    end

    context 'with a track with full morning talks' do
      it "add to afternoon talks" do
        expect{track_instance_with_full_morning.add_talk(Talk.new('Some Talk 12min'))}
          .to change{track_instance_with_full_morning.afternoon_talks.size}
      end
    end
  end

  describe 'to_output_format' do
    it "returns a string" do
      expect(track_instance_with_full_time.to_output_format).to be_an(String)
    end
    it "has track number in the beggining" do
      expect(track_instance_with_full_time.to_output_format).to match(/^Track \d:/)
    end
    it "has lunch" do
      expect(track_instance_with_full_time.to_output_format).to match(/12:00PM Lunch/)
    end
    it "has the networking event" do
      expect(track_instance_with_full_time.to_output_format).to match(/\d{2}:\d{2}PM Networking Event\n/)
    end
  end
end
