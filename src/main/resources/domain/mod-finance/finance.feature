Feature: finances operations

  Background:
    * url baseUrl
    * table modules
      | name              |
      | 'mod-finance'     |
      | 'mod-login'       |
      | 'mod-permissions' |

    * def admin = { tenant: 'diku', name: 'diku_admin', password: 'admin' }

    * def testTenant = 'test_finance'

    * def testAdmin = { tenant: '#(testTenant)', name: 'test-admin', password: 'admin' }
    * def testUser = { tenant: '#(testTenant)', name: 'test-user', password: 'test' }

    * table adminAdditionalPermissions
      | name          |
      | 'finance-storage.transactions.item.delete' |

    * table userPermissions
      | name          |
      | 'finance.all' |

    # specify global function login

  Scenario: create users for testing
    Given call read('classpath:common/setup-users.feature')

  Scenario: init global data
    # init test data for orders

  Scenario: transactions
    Given call read('cases/transactions.feature')

  Scenario: wipe data
    Given call read('classpath:common/destroy-data.feature')