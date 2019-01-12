#!/bin/sh

cd target/scala-2.12/
mkdir StandBy
unzip play-java-starter-example_2.12-1.0-SNAPSHOT-sources.jar -d ./StandBy
mv play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar StandBy/
cd StandBy
jar uf play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar ./*
mv play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar ../../../play-java-starter-example-1.0-SNAPSHOT/lib
cd ..
rm -rf StandBy
cd ../../play-java-starter-example-1.0-SNAPSHOT/lib
mv play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar play-java-starter-example.play-java-starter-example-1.0-SNAPSHOT-sans-externalized.jar
