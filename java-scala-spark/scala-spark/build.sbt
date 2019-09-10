name := "Simple Project"

version := "1.0"

scalaVersion := "2.11.12"

resourceDirectory in Compile := sourceDirectory.value

libraryDependencies += "org.apache.spark" %% "spark-sql" % "2.4.3"
