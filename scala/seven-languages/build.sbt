name := "seven-languages"

version := "1.0"

scalaVersion := "2.10.0-M4"

libraryDependencies ++= Seq(
  "com.novocode" % "junit-interface" % "0.9-RC2" % "test->default",
	"info.cukes" % "cucumber-junit" % "1.0.11" % "test",
	"info.cukes" % "cucumber-scala" % "1.0.11" % "test"
	)

seq(cucumberSettings : _*)

cucumberStepsBasePackage := "cucumber"

cucumberFeaturesDir := file("src/test/resources/cucumber")