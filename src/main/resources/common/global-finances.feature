Feature: global inventory

  Background:
    * url baseUrl
#    * callonce dev
    * call login testAdmin

    * configure headers = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'x-okapi-token': '#(okapitoken)' }

  Scenario: create fiscal year
    Given path 'finance/fiscal-years'
    And request
    """
    {
      "id": "ac2164c7-ba3d-1bc2-a12c-e35ceccbfaf2",
      "name": "TST-Fiscal Year 2020",
      "code": "FY2020",
      "description": "January 1 - December 30",
      "periodStart": "2020-01-01T00:00:00Z",
      "periodEnd": "2020-12-30T23:59:59Z",
      "series": "FY"
    }
    """
    When method POST
    Then status 201

  Scenario: create ledgers
    Given path 'finance-storage/ledgers'
    And request
    """
    {
        "id": "5e4fbdab-f1b1-4be8-9c33-d3c41ec9a695",
        "code": "TST-LDG",
        "ledgerStatus": "Active",
        "name": "Test ledger",
        "fiscalYearOneId": "ac2164c7-ba3d-1bc2-a12c-e35ceccbfaf2",
        "restrictEncumbrance": false
    }
    """
    When method POST
    Then status 201

  Scenario: create funds
    Given path 'finance-storage/funds'
    And request
    """
    {

      "id": "5e4fbdab-f1b1-4be8-9c33-d3c41ec9a696",
      "code": "TST-FND",
      "description": "Fund for orders API Tests",
      "externalAccountNo": "1111111111111111111111111",
      "fundStatus": "Active",
      "ledgerId": "5e4fbdab-f1b1-4be8-9c33-d3c41ec9a695",
      "name": "Fund for orders API Tests"
    }
    """
    When method POST
    Then status 201

  Scenario: create budget
    Given path 'finance/budgets'
    And request
    """
    {
      "id": "5e4fbdab-f1b1-4be8-9c33-d3c41ec9a697",
      "budgetStatus": "Active",
      "fundId": "5e4fbdab-f1b1-4be8-9c33-d3c41ec9a696",
      "name": "Budget for orders API Tests",
      "fiscalYearId":"ac2164c7-ba3d-1bc2-a12c-e35ceccbfaf2",
      "allocated": 9999999
    }
    """
    When method POST
    Then status 201

