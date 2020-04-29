import com.intuit.karate.junit5.Karate;

public class OrdersApiTest {

  @Karate.Test
  Karate orderTest() {
    return Karate.run("classpath:domain/mod-orders/orders.feature");
  }
}
