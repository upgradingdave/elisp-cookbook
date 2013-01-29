Feature: Reuse common elisp functions
  In order to keep my sanity
  As a elisp developer
  I want to write reusable elisp functions and libraries

  Scenario: Uncrompress gzipped response
    Given a response like "test/json-response.json"
    When I run 
    Then I should 
