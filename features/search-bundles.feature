
Feature: As a user of the API, I am able to search for bundles based on the content.
  Scenario: I am building a search functionality into my application.
    Given I am using the documentation API key
    And I know the following urls referenced as:
      | name                          | URL                                                                                                 |
      | media:future-of-women-flying  | http://archive.org/download/Greatest_Speeches_of_the_20th_Century/TheFutureofWomeninFlying_64kb.mp3 |
    When I search my bundles for the text "women"
    Then I should get the HTTP status code 200
    And my results should include a track with the URL "[media:future-of-women-flying]"
