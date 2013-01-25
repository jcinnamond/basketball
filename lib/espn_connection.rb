class ESPNConnection
  include Singleton

  attr_reader :base_url, :apikey

  def initialize
    config_path = File.join(Rails.root, "config", "espn.yml")
    connection_details = YAML::load_file(config_path)[Rails.env]
    @base_url = connection_details["base_url"]
    @apikey = connection_details["apikey"]
  end

  def get(path)
    resp = RestClient.get(url_for(path))
    json = JSON.parse(resp.body)
    json["sports"].first
  end

  private

  def url_for(path)
    url = base_url
    if path && ! path.blank?
      path = "/#{path}" unless path[0] == "/"
      url << path
    end
    url << "?apikey=#{apikey}"
  end
end
