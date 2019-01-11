build prod:
		sbt dist		
		unzip target/universal/play-java-starter-example-1.0-SNAPSHOT.zip 
		cd target/scala-2.12
		mkdir StandBy
		mv play-java-starter-example_2.12-1.0-SNAPSHOT-sources.jar StandBy/
		mv play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar StandBy/
		cd StandBy
		unzip play-java-starter-example_2.12-1.0-SNAPSHOT-sources.jar
		jar uf play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar META-INF
		jar uf play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar controllers
		jar uf play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar filters
		jar uf play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar services
		jar uf play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar routes
		jar uf play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar Module.java
		jar uf play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar application.conf
		jar uf play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar logback.xml
		mv play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar ../../../play-java-starter-example-1.0-SNAPSHOT/lib/
		cd ../../../play-java-starter-example-1.0-SNAPSHOT/lib/
		mv play-java-starter-example_2.12-1.0-SNAPSHOT-sans-externalized.jar play-java-starter-example.play-java-starter-example-1.0-SNAPSHOT-sans-externalized.jar
		cd play-java-starter-example-1.0-SNAPSHOT/bin
		../../play-java-starter-example-1.0-SNAPSHOT/bin/play-java-starter-example -Dplay.file=../conf/application.conf
		
run prod:
		chmod +x play-java-starter-example-1.0-SNAPSHOT/bin/play-java-starter-example
		play-java-starter-example-1.0-SNAPSHOT/bin/play-java-starter-example -Dplay.file=../conf/application.conf

run dev:
		mkdir -p lib
		wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST" -O ./lib/rook.jar
		sbt package
		sbt run

		
