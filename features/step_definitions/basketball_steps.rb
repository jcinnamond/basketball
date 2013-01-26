Then /^I should see the following leagues:$/ do |table|
  league_names = table.raw
  navigation = page.find("nav")
  league_names.each do |name|
    navigation.should have_link(name.first)
  end
end

Then /^I should see the following teams:$/ do |table|
  team_names = table.raw
  team_names.each do |name|
    page.should have_link(name.first)
  end
end
