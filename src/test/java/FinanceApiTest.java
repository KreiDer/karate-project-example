import com.intuit.karate.junit5.Karate;

public class FinanceApiTest {

  @Karate.Test
  Karate financesTest() {
    return Karate.run("classpath:domain/mod-finance/finance.feature");
  }
}
