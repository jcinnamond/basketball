require 'espn_model'

class Team
  include ESPNModel

  attributes :name, :id
  set_path "teams"
end
