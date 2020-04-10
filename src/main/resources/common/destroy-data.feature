Feature: destroy data for tenant

  Background:
    * url baseUrl
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
    * configure readTimeout = 90000
    * def admin = { tenant: 'diku', name: 'diku_admin', password: 'admin' }
    * def testUser = { tenant: 'test_orders', name: 'test-user', password: 'test' }
    * callonce read('classpath:common/login.feature') admin

  Scenario: purge all modules for tenant

    Given path '_/proxy/tenants', testUser.tenant, 'modules'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header x-okapi-token = okapitoken
    When method GET
    Then status 200
    * set response $[*].action = 'disable'
    * print response


    Given path '_/proxy/tenants', testUser.tenant, 'install'
    And param purge = true
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header x-okapi-token = okapitoken
    And request response
    When method POST
    Then status 200

  Scenario: delete tenant
    Given call read('classpath:common/tenant.feature@delete') { tenant: '#(testUser.tenant)'}

