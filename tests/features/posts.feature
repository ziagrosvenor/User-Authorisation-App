Feature: User Posts

  Background:
    Given I visit Auth App

  Scenario: Creating a post
    When I login with "foo@foo.com", "foobar"
    Then I can post "post title", "post content"
    Then I can see "post title", "post content"
    Then I can edit the post to read "new title", "new content"
    Then I can delete the post