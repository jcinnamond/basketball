require 'espn_model'

class News
  include ESPNModel

  attributes :headline, :description, :images
  set_path :news
  set_key :headlines
end
