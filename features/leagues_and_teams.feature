Feature: Leagues and teams
  In order to select a team to show news for
  As a user
  I want to see a list of leagues and teams

  Scenario: List of leagues
    Given a successful response from ESPN
    When I go to the application page
    Then I should see the following leagues:
      | National Basketball Assoc.         |
      | Women's National Basketball Assoc. |
      | NCAA Basketball                    |
      | NCAA Women's Basketball            |
