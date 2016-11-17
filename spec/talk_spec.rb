require_relative 'spec_helper'

describe Talk do
  let(:minutes){"#{[*5..60].sample}min"}
  let(:title){"My awesome talk"}
  let(:talk_instance){Talk.new("#{title} #{minutes}")}
  let(:lightning_talk_instance){Talk.new("#{title} lightning")}
  let(:some_time){Time.now}
  let(:talk_instance_with_start_time) do
    talk_instance.start_time = some_time
    talk_instance
  end

  describe 'atrributes' do
    describe 'title' do
      it "returns a string" do
        expect(talk_instance.title).to be_an(String)
      end

      it {expect(talk_instance.title).to eq title}
    end

    describe 'duration' do
      it "returns as string" do
        expect(talk_instance.duration).to be_an(String)
      end

      it {expect(talk_instance.duration).to eq minutes}

      context 'when talk duration is lightning' do
        it {expect(lightning_talk_instance.duration).to eq('lightning')}
      end
    end

    describe 'start_time' do
      it 'stores the start time of the talk' do
        talk_instance.start_time = some_time
        expect(talk_instance.start_time).to eq(some_time)
      end
    end
  end

  describe '#duration_in_minutes' do
    context 'when talk is in minutes' do
      it "return the duration in minutes" do
        expect(talk_instance.duration_in_minutes).to eq(minutes)
      end
    end

    context 'when talk is lightning' do
      it "return the duration in minutes" do
        expect(lightning_talk_instance.duration_in_minutes).to eq('5min')
      end
    end
  end

  describe '#time_duration' do
    it "returns a Integer" do
      expect(talk_instance.time_duration).to eq(minutes.to_i)
    end
  end

  describe '#end_time' do
    context 'when has a start_time' do
      it "returns the start time + duration" do
        expect(talk_instance_with_start_time.end_time)
          .to eq(talk_instance_with_start_time.start_time + (talk_instance_with_start_time.time_duration) * 60)
      end
    end
  end

  describe 'to_output_format' do
    it "returns a string" do
      expect(talk_instance_with_start_time.to_output_format).to be_an(String)
    end

    it "returns a valid output" do
      expect(talk_instance_with_start_time.to_output_format).to match(/\d{2}:\d{2}(AM|PM) \w+/)
    end
  end

end
