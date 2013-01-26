# See features/support/espn_mocking for the loading of the
# espn mocking module which defines mock_espn_* methods.

Given /^a successful response from ESPN$/ do
  mock_espn_success
end
