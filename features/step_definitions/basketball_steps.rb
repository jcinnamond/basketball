Then /^I should see the following leagues:$/ do |table|
  league_names = table.raw
  navigation = find("nav")
  league_names.each do |name|
    navigation.should have_link(name.first)
  end
end
