# Add rspec's support directory to the load path so that
# we can use the common ESPNMocking module
$LOAD_PATH.unshift(File.join(Rails.root, "spec", "support"))

require 'webmock/cucumber'
require 'espn_mocking'
World(ESPNMocking)

# Make sure we don't block access to localhost
WebMock.disable_net_connect!(:allow_localhost => true)
