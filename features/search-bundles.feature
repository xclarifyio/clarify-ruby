
Feature: As a user of the API, I am able to search for bundles based on the content.
  Scenario: I am building a search functionality into my application.
    Given I am using the documentation API key
    And I know the following urls referenced as:
      | name                          | URL                                                                                                |
      | media:creativity              | http://media.clarify.io/video/presentations/SirKenRobinson-TED2006-How-Schools-Kill-Creativity.mp4 |
    When I search my bundles for the text "creativity"
    Then I should get the HTTP status code 200
    And my results should include a track with the URL "[media:creativity]"
