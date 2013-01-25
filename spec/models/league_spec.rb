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
      @league = League.new(
        :name => "Test league",
        :short_name => "TL",
        :id => 123,
        :abbreviation => "test-league"
      )
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

    it "has an abbreviation" do
      expect(@league.abbreviation).to eq("test-league")
    end
  end

  it "returns its attributes as json" do
    # See spec/support/espn_mocking.rb
    mock_espn_success

    league = League.first
    json_data = league.as_json
    expect(json_data[:name]).to eq("National Basketball Assoc.")
    expect(json_data[:short_name]).to eq("NBA")
    expect(json_data[:id]).to eq(46)
    expect(json_data[:abbreviation]).to eq("nba")
  end

  describe "teams" do
    before :each do
      # See spec/support/espn_mocking.rb
      mock_espn_success
      @league = League.first
      @teams = @league.teams
    end

    it "returns a list of teams" do
      expect(@teams).to be_an(Array)
      expect(@teams.map(&:class).uniq).to eq([Team])
    end

    it "sets each team name" do
      names = @teams.map(&:name)
      expect(names).to eq(["Tigers", "Blazers", "Jaguars"])
    end

    it "sets each team id" do
      ids = @teams.map(&:id)
      expect(ids).to eq([2, 5, 6])
    end

    it "returns the teams in the json" do
      json_data = @league.as_json
      teams = json_data[:teams]
      expect(teams).to include({name:"Tigers",id:2})
      expect(teams).to include({name:"Blazers",id:5})
      expect(teams).to include({name:"Jaguars",id:6})
    end
  end
end
