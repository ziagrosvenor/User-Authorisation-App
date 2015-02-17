Feature: Simple Feature

  Background:
    Given I visit Auth App

  Scenario: Creating an account
    When I enter "dan", "jones", "example@example.com", "password" 
    Then I should see "dan", "jones", "example@example.com", "password"
    Then I should see feedback for verified inputs