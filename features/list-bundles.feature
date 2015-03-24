Feature: As a user of the API, I am able to list my submitted bundles.
  Scenario: I am building an index page to my bundle collection.
    Given I am using the documentation API key
    And I know the following urls referenced as:
      | name                          | URL                                                                                                                 |
      | media:future-of-women-flying  | http://archive.org/download/Greatest_Speeches_of_the_20th_Century/TheFutureofWomeninFlying_64kb.mp3                 |
      | media:watergate-tapes         | http://ia700200.us.archive.org/18/items/Greatest_Speeches_of_the_20th_Century/OnReleasingtheWatergateTapes_64kb.mp3 |
      | media:resignation-address     | http://ia600200.us.archive.org/18/items/Greatest_Speeches_of_the_20th_Century/ResignationAddress-1974_64kb.mp3      |
    When I request a list of bundles
    Then I should get the HTTP status code 200
    And my results should include a track with the URL "[media:future-of-women-flying]"
    And my results should include a track with the URL "[media:watergate-tapes]"
    And my results should include a track with the URL "[media:resignation-address]"
