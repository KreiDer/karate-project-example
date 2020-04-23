Feature: test

  Background:
    * url baseUrl
    * def admin = { tenant: 'diku', name: 'diku_admin', password: 'admin' }
#    * call read('classpath:common/login.feature') admin

  Scenario: test
    * print uuid()
    * print uuid()


