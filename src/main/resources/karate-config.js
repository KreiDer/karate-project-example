function fn() {

  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  var config = {
    baseUrl: 'http://localhost:9130',
    diku: {tenant: 'diku', name: 'diku_admin', password: 'admin'},
    // baseUrl : 'https://folio-testing-okapi.aws.indexdata.com:443'
    // define global features
    login: karate.read('classpath:common/login.feature'),
    dev: karate.read('classpath:common/dev.feature'),

    // define global functions
    uuid: function () {
      return java.util.UUID.randomUUID() + ''
    }
  };
  return config;
}
