module ESPNMocking
  def mock_espn_success
    mock_espn("", :league_success)
    mock_espn("/nba/teams", :teams_success)
    mock_espn("/wnba/teams", :teams_success)
    mock_espn("/mens-college-basketball/teams", :teams_success)
    mock_espn("/womens-college-basketball/teams", :teams_success)
  end

  def mock_espn(url, fixture)
    filename = File.join(Rails.root, "spec", "fixtures", fixture.to_s)
    fixture_data = File.read(filename)
    stub_request(:get, "http://api.espn.com/v1/sports/basketball#{url}?apikey=test_key").to_return(
      :body => fixture_data,
      :status => 200,
      :headers => { 'Content-Type' => 'application/json;charset=UTF-8' }
    )
  end
end
