Feature: ngfp-awareness page content test

  @smoke
  Scenario Outline: As a user of ngfp awareness application I need to make sure that all designed elements are displayed on the page
    Given I am on the "awareness" page
    Then the element: "<element>" is visible on the page

    Examples:
      | element          |
      | Awareness header |
      | Refresh button   |
      | Awareness events |

  @smoke
  Scenario Outline: As a user of ngfp awareness application I need to make sure that table section contains designed columns
    Given I am on the "awareness" page
    Then the element: "<element>" with value "<value>" is visible on the page

    Examples:
      | element              | value   |
      | Table header element | Plan    |
      | Table header element | File    |
      | Table header element | Release |
      | Table header element | Out     |
      | Table header element | Off     |
      | Table header element | On      |
      | Table header element | In      |

  @smoke
  Scenario Outline: As a user of ngfp awareness application I need to make sure that SDT filtering buttons are present on the page
    Given I am on the "awareness" page
    Then the element: "<element>" with value "<value>" is visible on the page

    Examples:
      | element    | value |
      | STD button | 30m   |
      | STD button | 2h    |
      | STD button | 6h    |
      | STD button | 24h   |
      | STD button | +1d   |

  @smoke
  Scenario: As a user of ngfp awareness application I need to make sure that awareness table content can be refreshed
    Given I am on the "awareness" page
    When I hover the mouse over "Refresh button" element
    And the element: "Refresh tooltip" is visible on the page
    And I click the "Refresh button" button
    Then the element: "Flights loader spinner" is visible on the page

  @smoke
  Scenario Outline: As a user of ngfp awareness application I need to make sure that status tiles are displayed within kanban cards
    Given I am on the "awareness" page
    Then the element: "<element>" with value "<value>" is visible on the page

    Examples:
      | element     | value |
      | Status tile | OFP   |
      | Status tile | TRIAL |
      | Status tile | FILE  |
      | Status tile | BRIEF |


  @smoke
  Scenario Outline: As a user of ngfp awareness application I need to make sure that upon clicking status filter status buttons are present
    Given I am on the "awareness" page
    When I click the "Filter" button with parameter "<column_name>"
    Then the element: "<label>" with value "<column_name>" is visible on the page
    And the element: "<yellow_status>" with value "<column_name>" is visible on the page
    And the element: "<red_status>" with value "<column_name>" is visible on the page

    Examples:
      | column_name | label        | yellow_status        | red_status        |
      | Plan        | Status label | Yellow status filter | Red status filter |
      | File        | Status label | Yellow status filter | Red status filter |
      | Release     | Status label | Yellow status filter | Red status filter |
      | Out         | Status label | Yellow status filter | Red status filter |
      | Off         | Status label | Yellow status filter | Red status filter |
      | On          | Status label | Yellow status filter | Red status filter |
      | In          | Status label | Yellow status filter | Red status filter |

  @smoke
  Scenario: As a user of ngfp awareness application I need to make sure that search function returns requested kanban element
    Given I am on the "awareness" page
    When I fill in the "Search" input with "red_status"
    Then the element: "Kanban card" with value "red_status" is visible on the page
    And the element: "Kanban card" with value "yellow_status" is not visible on the page
    And the element: "Kanban card" with value "green_status" is not visible on the page
    And the element: "Kanban card" with value "white_status" is not visible on the page

  @smoke
  Scenario: As a user of ngfp awareness application I need to make sure that "yellow status" filter function returns requested kanban elements
    Given I am on the "awareness" page
    When I click the "Filter" button with parameter "Plan"
    And I click the "Yellow status filter" button with parameter "Plan"
    Then the "Yellow status filter" "aria-selected" attribute should contain the text "true"
    And the element: "Kanban card" with value "yellow_status" is visible on the page
    And the element: "Kanban card" with value "red_status" is not visible on the page
    And the element: "Kanban card" with value "green_status" is not visible on the page
    And the element: "Kanban card" with value "white_status" is not visible on the page

  @smoke
  Scenario: As a user of ngfp awareness application I need to make sure that "red status" filter function returns requested kanban elements
    Given I am on the "awareness" page
    When I click the "Filter" button with parameter "Plan"
    And I click the "Red status filter" button with parameter "Plan"
    Then the "Red status filter" "aria-selected" attribute should contain the text "true"
    And the element: "Kanban card" with value "red_status" is visible on the page
    And the element: "Kanban card" with value "yellow_status" is not visible on the page
    And the element: "Kanban card" with value "green_status" is not visible on the page
    And the element: "Kanban card" with value "white_status" is not visible on the page
