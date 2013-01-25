module ESPNMocking
  def mock_espn_success
    mock_espn("", :league_success)
  end

  def mock_espn(url, fixture)
    filename = File.join(Rails.root, "spec", "fixtures", fixture.to_s)
    fixture_data = File.read(filename)
    stub_request(:get, %r{http://api.espn.com/v1/sports/basketball#{url}\?apikey=.*}).to_return(
      :body => fixture_data,
      :status => 200,
      :headers => { 'Content-Type' => 'application/json;charset=UTF-8' }
    )
  end
end
