require 'spec_helper'

describe League do
  describe '.all' do
    describe 'with a valid response from ESPN' do
      before :each do
        # See spec/support/espn_mocking.rb
        mock_espn_success
      end

      it "returns an array of League objects" do
        league_objects = League.all
        expect(league_objects).to be_an(Array)
        expect(league_objects.map(&:class).uniq).to eq([League])
      end

      it "includes one object per League returned from ESPN" do
        league_names = League.all.map(&:short_name)
        expect(league_names).to eq(["NBA", "WNBA", "NCAA Basketball", "NCAA Women's Basketball"])
      end
    end
  end

  describe "attributes" do
    before :each do
      @league = League.new(:name => "Test league", :short_name => "TL", :id => 123)
    end

    it "has a name" do
      expect(@league.name).to eq("Test league")
    end

    it "has a short_name" do
      expect(@league.short_name).to eq("TL")
    end

    it "has an id" do
      expect(@league.id).to eq(123)
    end
  end

  it "returns its attributes as json" do
    league = League.new(:name => "Test League", :short_name => "TL", :id => 123)
    expect(league.as_json).to eq({name:"Test League",short_name:"TL",id:123})
  end
end
