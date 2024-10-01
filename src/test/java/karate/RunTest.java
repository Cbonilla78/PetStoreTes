package karate;
import com.intuit.karate.junit5.Karate;
public class RunTest {
    @Karate.Test
    Karate testSample() {
        return Karate.run("petstore").relativeTo(getClass());
    }
}
