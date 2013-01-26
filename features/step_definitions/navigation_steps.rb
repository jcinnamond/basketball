When /^I go to the application page$/ do
  visit '/'
end

When /^I click on "([^"]+)"$/ do |name|
  page.click_link(name)
end
