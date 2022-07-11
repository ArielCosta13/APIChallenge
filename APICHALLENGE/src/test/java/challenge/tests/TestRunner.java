package challenge.tests;

import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate challengeTest() {
        return Karate.run("challengeTests").relativeTo(getClass()); }

}
