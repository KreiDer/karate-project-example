Feature: Test orders

  Background:
    * url baseUrl
    # Login user as test admin
    * def testUser = { tenant: 'test_orders', name: 'test-user', password: 'test' }
    * callonce read('classpath:common/login.feature') testUser
    * configure headers = { 'Content-Type': 'application/json', 'x-okapi-token': '#(okapitoken)'  }
    * def vendor = callonce read('classpath:common/organizations.feature@createVendor')

  Scenario Outline: create composite orders
    # Create composite orders
    Given path 'orders/composite-orders'
    And header Accept = 'application/json'
    And def activeVendorId = vendor.activeVendorId
    And request
    """
    {
      vendor: #(activeVendorId),
      orderType: 'One-Time'
    }
    """
    When method POST
    Then status 201
    * def orderId = response.id

    # get created composite order
    Given path 'orders/composite-orders', orderId
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And match response contains { id: '#(orderId)' }

    # update poNumber
    * set response.poNumber = <poNumber>
    Given path 'orders/composite-orders', orderId
    And header Accept = 'application/json'
    And request response
    When method PUT
    Then status 204

    # check poNumber has been updated
    Given path 'orders/composite-orders', orderId
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And match response contains { poNumber: <poNumber> }

    Examples:
      | poNumber  |
      | '11238' |
      | '11239' |
      | '11230' |
