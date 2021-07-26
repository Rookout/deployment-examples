import Dependencies._

ThisBuild / scalaVersion     := "2.11.8"
ThisBuild / version          := "0.1.0-SNAPSHOT"
ThisBuild / organization     := "com.example"
ThisBuild / organizationName := "example"

resourceDirectory in Compile := sourceDirectory.value

lazy val root = (project in file("."))
  .settings(
    name := "hello",
    libraryDependencies += scalaTest % Test
)

libraryDependencies += "org.scala-lang" % "scala-reflect" % scalaVersion.value