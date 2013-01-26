@javascript
Feature: Showing team news
  In order to find out about a team
  As a user
  I want to select a team and see the news for it

  Scenario: Showing the news
    Given a successful response from ESPN
    And I go to the application page
    When I click on "Jaguars"
    Then I should see the team name "Jaguars"
    And I should see the following news:
      | headline | description      |
      | A'dia Mathies' best game of year helps Kentucky roll Auburn | A'dia Mathies scored a season-best 24 points to help No. 5 Kentucky rout Auburn 97-53 on Sunday. |
      | Meighan Simmons rallies No. 9 Tennessee to win over Auburn | Meighan Simmons scored 18 of her 29 points after halftime and No. 9 Tennessee rallied from a 12-point deficit in the second half for a 75-66 victory over Auburn on Thursday night. |
