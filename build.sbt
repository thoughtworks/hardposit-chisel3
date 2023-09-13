// See LICENSE for license details.


ThisBuild / organization     := "com.thoughtworks"
ThisBuild / version          := "1.1.0"
ThisBuild / scalaVersion     := "2.13.10"

val chiselVersion = "3.6.0"
val chiselTestVersion = "0.6.0"

lazy val root = (project in file("."))
  .settings(
    name := "hardposit",
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % chiselVersion,
      "edu.berkeley.cs" %% "chiseltest" % chiselTestVersion,
    ),
    scalacOptions ++= Seq(
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit",
      "-P:chiselplugin:genBundleElements",
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % chiselVersion cross CrossVersion.full),
  )


// Recommendations from http://www.scalatest.org/user_guide/using_scalatest_with_sbt
Test / logBuffered := false

// Disable parallel execution when running tests.
//  Running tests in parallel on Jenkins currently fails.
Test / parallelExecution := false

