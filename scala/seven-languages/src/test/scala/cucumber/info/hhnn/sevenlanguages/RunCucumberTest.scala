package cucumber.info.hhnn.sevenlanguages

import org.junit.runner.RunWith
import org.junit.Test
import cucumber.junit.Cucumber

@Test
@RunWith(classOf[Cucumber])
@Cucumber.Options(format =  Array("junit:target/junit"))
class RunCucumberTest() {

}