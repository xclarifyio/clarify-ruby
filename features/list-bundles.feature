Feature: As a user of the API, I am able to list my submitted bundles.
  Scenario: I am building an index page to my bundle collection.
    Given I am using the documentation API key
    And I know the following urls referenced as:
      | name                          | URL                                                                |
      | media:statue-of-liberty       | http://media.clarify.io/audio/speeches/FDR-Statue-of-Liberty.mp3   |
      | media:gwb-victory-speech      | http://media.clarify.io/audio/speeches/GWB-2004-Victory-Speech.mp3 |
      | media:harvard-sentences       | http://media.clarify.io/audio/samples/harvard-sentences-2.wav      |
    When I request a list of bundles
    Then I should get the HTTP status code 200
    And my results should include a track with the URL "[media:statue-of-liberty]"
    And my results should include a track with the URL "[media:gwb-victory-speech]"
    And my results should include a track with the URL "[media:harvard-sentences]"
