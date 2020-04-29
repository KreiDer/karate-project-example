function fn() {

  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  var env = karate.env;

  var config = {
    baseUrl: 'http://localhost:9130',
    admin: {tenant: 'diku', name: 'diku_admin', password: 'admin'},

    // define global features
    login: karate.read('classpath:common/login.feature'),
    dev: karate.read('classpath:common/dev.feature'),

    // define global functions
    uuid: function () {
      return java.util.UUID.randomUUID() + ''
    },
    validate: function (json, schemaName) {
      var SchemaValidator = Java.type('org.folio.SchemaValidator');
      return SchemaValidator.isValid(json, schemaName);
    }
  };

  if (env == 'testing') {
    config.baseUrl = 'https://folio-testing-okapi.aws.indexdata.com:443';
    config.admin = {
      tenant: 'supertenant',
      name: 'testing_admin',
      password: 'admin'
    }
  } else if (env == 'snapshot') {
    config.baseUrl = 'https://folio-snapshot-okapi.aws.indexdata.com:443';
    config.admin = {
      tenant: 'supertenant',
      name: 'testing_admin',
      password: 'admin'
    }
  }
  return config;
}
