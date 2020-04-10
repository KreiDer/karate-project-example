Feature: prepare data for api test

  Background:
    * url baseUrl
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
    * configure readTimeout = 90000
    * def admin = { tenant: 'diku', name: 'diku_admin', password: 'admin' }
    * def testUser = { tenant: 'test_orders', name: 'test-user', password: 'test' }
    * callonce read('classpath:common/login.feature') admin

  Scenario: create new tenant '#(testUser.tenant)'
    * call read('classpath:common/tenant.feature@create') { tenant: '#(testUser.tenant)'}

  Scenario: get and install configured modules
    And call read('classpath:common/tenant.feature@install') { modules: '#(modules)', tenant: '#(testUser.tenant)'}

  Scenario: create test user

    Given path 'users'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header x-okapi-tenant = testUser.tenant
    And request
    """
    {
      "id":"00000000-1111-5555-9999-999999999997",
      "username":"#(testUser.name)",
      "active":true,
      "personal": {"firstName":"Admin","lastName":"Orders API Tests"}
    }
    """
    When method POST
    Then status 201

  Scenario: specify user credentials

    Given path 'authn/credentials'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header x-okapi-tenant = testUser.tenant
    And request {username: '#(testUser.name)', password :'#(testUser.password)'}
    When method POST
    Then status 201


  Scenario: add permissions to user

    Given path 'perms/users'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header x-okapi-tenant = testUser.tenant
    And request
    """
    {
      "userId":"00000000-1111-5555-9999-999999999997",
      "permissions":[
        "configuration.all",
        "inventory.all",
        "isbn-utils.all",
        "organizations-storage.module.all",
        "finance.module.all",
        "inventory-storage.all",
        "login.all",
        "orders-storage.module.all",
        "finance.all",
        "users.all",
        "user-settings.custom-fields.all",
        "perms.all",
        "acquisitions-units.units.all",
        "orders.all",
        "acquisitions-units.memberships.all",
        "modperms.orders.item.put",
        "modperms.orders.item.post"]
    }
    """
    When method POST
    Then status 201

  Scenario: enable mod-authtoken modules
    Given call read('classpath:common/tenant.feature@install') { modules: [{name: 'mod-authtoken'}], tenant: '#(testUser.tenant)'}
