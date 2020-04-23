package setup.tenant;

import com.intuit.karate.junit5.Karate;

public class AllApiTest {

  @Karate.Test
  Karate orderTest() {
    return Karate.run("classpath:domain/mod-orders/orders.feature");
  }

  @Karate.Test
  Karate financesTest() {
    return Karate.run("classpath:domain/mod-finance/finance.feature");
  }
}
