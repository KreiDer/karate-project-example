package setup.tenant;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Order;

public class OrdersApiTest {

  @Order(1)
  @Karate.Test
  Karate init() {
    return Karate.run("classpath:setup-data.feature");
  }

  @Order(2)
  @Karate.Test
  Karate orderTest() {
    return Karate.run("classpath:orders.feature");
  }

  @Order(3)
  @Karate.Test
  Karate destroy() {
    return Karate.run("classpath:destroy-data.feature");
  }
}
