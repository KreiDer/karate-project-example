Feature: Orders

  Background:
    * url baseUrl
    * table modules
      | name                |
      | 'mod-orders'        |
      | 'mod-login'         |
      | 'mod-permissions'   |
      | 'mod-configuration' |

    * def admin = { tenant: 'diku', name: 'diku_admin', password: 'admin' }

    * def testTenant = 'test_orders3'

    * def testAdmin = { tenant: '#(testTenant)', name: 'test-admin', password: 'admin' }
    * def testUser = { tenant: '#(testTenant)', name: 'test-user', password: 'test' }

    * table adminAdditionalPermissions
      | name          |

    * table userPermissions
      | name         |
      | 'orders.all' |

    # specify global function login

  Scenario: create users for testing
    Given call read('classpath:common/setup-users.feature')

  Scenario: init global data
    # init test data for orders
    * call login testAdmin

    * callonce read('classpath:common/global-inventory.feature')
    * callonce read('classpath:common/global-finances.feature')
    * callonce read('classpath:common/global-organizations.feature')

  Scenario: create composite orders
    Given call read('cases/composite-orders.feature')

  Scenario: wipe data
    Given call read('classpath:common/destroy-data.feature')
