require 'espn_model'

class League
  include ESPNModel

  key :leagues
  attributes :name, :short_name, :id
end
