Feature: Visual regression and accessibility testing
  In order to make changes to the prototype
  As a developer
  I want to make sure I don't break the current visual style and accessibility of the screens.  

  Scenario: Landing page
    When  I open the url "/index.html"
    Then  I expect the screenshot of "landing-page" matches the web page
    And   I expect the "landing-page" page has no accessibility errors

  Scenario: Student dashboard
    When  I click the link "a#dashboard-student" and wait for the element "main"
    And   I wait for 2 seconds
    Then  I expect the screenshot of "dashboard-student" matches the web page
    And   I expect the "dashboard-student" page has no accessibility errors

  Scenario: Quiz start
    When  I open the url "/index.html"
    And   I click the link "a#quiz" and wait for the element "main"
    And   I wait for 2 seconds
    Then  I expect the screenshot of "quiz-start" matches the web page
    And   I expect the "quiz-start" page has no accessibility errors

  Scenario: Quiz question 1
    When  I click the link "main .btn-primary" and wait for the element "form#question-1"
    And   I wait for 2 seconds
    Then  I expect the screenshot of "quiz-question-1" matches the web page
    And   I expect the "quiz-question-1" page has no accessibility errors

  Scenario: Quiz question 2
    When  I click the element "form#question-1 button[type='submit']" and wait for the element "form#question-2"
    And   I wait for 2 seconds
    Then  I expect the screenshot of "quiz-question-2" matches the web page
    And   I expect the "quiz-question-2" page has no accessibility errors

  Scenario: Quiz question 3
    When  I click the element "form#question-2 button[type='submit']" and wait for the element "form#question-3"
    And   I wait for 2 seconds
    Then  I expect the screenshot of "quiz-question-3" matches the web page
    And   I expect the "quiz-question-3" page has no accessibility errors

  Scenario: Quiz end
    When  I click the element "form#question-3 button[type='submit']" and wait for the element "#quiz-results-chart"
    And   I wait for 2 seconds
    Then  I expect the screenshot of "quiz-end" matches the web page
    And   I expect the "quiz-end" page has no accessibility errors                                   
