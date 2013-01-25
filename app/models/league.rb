require 'espn_model'

class League
  include ESPNModel

  attributes :name, :short_name, :id, :abbreviation
  has_many :teams

  def to_id
    self.abbreviation
  end
end
