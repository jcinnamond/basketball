Then /^I should see the team name "(.*)"$/ do |name|
  page.find("#team-name").should have_content(name)
end

Then /^I should see the following news:$/ do |table|
  page.driver.render("/tmp/page.png", :full => true)
  main = page.find("#news-list")
  news = table.hashes
  news.each do |news_item|
    main.find('h3', :text => news_item["headline"])
    main.find("p", :text => news_item["description"])
  end
end
