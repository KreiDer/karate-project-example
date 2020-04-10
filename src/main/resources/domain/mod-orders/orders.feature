Feature: Test

  Background:
    * url baseUrl
    * table modules
      | name                |
      | 'mod-orders'        |
      | 'mod-login'         |
      | 'mod-permissions'   |
      | 'mod-configuration' |

  Scenario: init data
    Given call read('classpath:common/setup-data.feature')

  Scenario: create composite orders
    Given call read('composite-orders.feature')

  Scenario: wipe data
    Given call read('classpath:common/destroy-data.feature')
