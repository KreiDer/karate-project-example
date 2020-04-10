Feature: Test vendor

  Background:
    * url baseUrl

  @createVendor
  Scenario: create vendor
    Given path 'organizations-storage/organizations'
    And header Accept = 'application/json'
    And request
    """
    {
      name: 'Test active vendor',
      code: 'TEST5',
      isVendor: true,
      status: 'Active'
    }
    """
    When method POST
    Then status 201

    * def activeVendorId = response.id

  @deleteVendor
  Scenario: delete vendor
    Given path 'organizations-storage/organizations', __arg.id
    And header Accept = 'text/plain'
    When method DELETE
    Then status 204

