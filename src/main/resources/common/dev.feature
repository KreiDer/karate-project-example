Feature: dev

  Scenario: init dev data

#    * def testTenant = 'test_orders3'
    * def testTenant = 'test_finance'
    * def testAdmin = { tenant: '#(testTenant)', name: 'test-admin', password: 'admin' }
    * def testUser = { tenant: '#(testTenant)', name: 'test-user', password: 'test' }
