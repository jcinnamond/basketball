require 'spec_helper'

describe NewsController do
  describe "GET 'index'" do
    describe "with a valid response from ESPN" do
      before :each do
        # See spec/support/espn_mocking.rb
        mock_espn_success
      end

      def do_action
        get :index, :league_id => "nba", :team_id => 1
      end

      it "is successful" do
        do_action
        expect(response).to be_successful
      end

      it "returns the headlines" do
        do_action
        news_items = JSON.parse(response.body)
        headlines = news_items.map { |n| n["headline"] }
        expect(headlines).to eq(["A'dia Mathies' best game of year helps Kentucky roll Auburn",
                                "Meighan Simmons rallies No. 9 Tennessee to win over Auburn"])
      end

      it "returns the descriptions" do
        do_action
        news_items = JSON.parse(response.body)
        descriptions = news_items.map { |n| n["description"] }
        expect(descriptions).to eq(["A'dia Mathies scored a season-best 24 points to help No. 5 Kentucky rout Auburn 97-53 on Sunday.",
                                "Meighan Simmons scored 18 of her 29 points after halftime and No. 9 Tennessee rallied from a 12-point deficit in the second half for a 75-66 victory over Auburn on Thursday night."])
      end

      it "returns the images" do
        do_action
        news_items = JSON.parse(response.body)
        images = news_items.map { |n| n["images"] }
        expect(images).to eq([[], []])
      end
    end
  end
end
