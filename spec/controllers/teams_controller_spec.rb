require 'spec_helper'

describe TeamsController do
  describe "GET 'index'" do
    describe "with a valid response from ESPN" do
      before :each do
        # See spec/support/espn_mocking.rb
        mock_espn_success
      end

      def do_action
        get :index
      end

      it "is successful" do
        do_action
        expect(response).to be_successful
      end

      it "returns valid json" do
        do_action
        expect {
          JSON.parse(response.body)
        }.to_not raise_error
      end

      it "returns the leagues" do
        do_action
        leagues = JSON.parse(response.body)
        league_names = leagues.map { |l| l["short_name"] }
        expect(league_names).to eq(["NBA", "WNBA", "NCAA Basketball", "NCAA Women's Basketball"])
      end

      it "returns the teams for each league" do
        do_action
        first_league = JSON.parse(response.body).first
        teams = first_league["teams"]
        expect(teams).to eq(
          [
            { "name" => "Tigers", "id" => 2 },
            { "name" => "Blazers", "id" => 5},
            { "name" => "Jaguars", "id" => 6}
        ]
        )
      end
    end
  end
end
