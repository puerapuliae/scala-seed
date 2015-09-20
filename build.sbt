name := "scala-seed"

organization := "net.puerapuliae"

licenses += ("Apache-2.0", url("http://www.apache.org/licenses/LICENSE-2.0"))

scalaVersion := "2.11.7"

scalacOptions ++= Seq(
  "-deprecation"
  ,"-unchecked"
  ,"-encoding", "UTF-8"
  ,"-Xlint"
  ,"-Yclosure-elim"
  ,"-Yinline"
  ,"-Xverify"
  ,"-feature"
  ,"-language:postfixOps"
  ,"-optimise"
)

javacOptions ++= Seq("-Xlint:unchecked", "-Xlint:deprecation")

libraryDependencies ++= Seq (
  "org.scalatest" %% "scalatest" % "2.2.4" % "test",
  "org.scalacheck" %% "scalacheck" % "1.12.5"
)

fork := true

testOptions in Test += Tests.Argument("-oDS")

resolvers ++= Seq(
  Resolver.typesafeRepo("snapshots")
)

scalaSource in Compile := baseDirectory.value / "src"

scalaSource in Test := baseDirectory.value / "src"

excludeFilter in (Compile, unmanagedSources) := HiddenFileFilter || "*_test.scala"

excludeFilter in (Test, unmanagedSources) := HiddenFileFilter

resourceDirectory in Compile := baseDirectory.value / "resources"

resourceDirectory in Test := baseDirectory.value / "resources"

scalariformSettings
