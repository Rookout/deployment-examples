build prod:
		sbt dist		
		unzip target/universal/play-java-starter-example-1.0-SNAPSHOT.zip 
		chmod +x adding_src.sh
		./adding_src.sh
		chmod +x play-java-starter-example-1.0-SNAPSHOT/bin/play-java-starter-example
		play-java-starter-example-1.0-SNAPSHOT/bin/play-java-starter-example -Dplay.file=../conf/application.conf
run dev:
		mkdir -p lib
		wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST" -O ./lib/rook.jar
		sbt package
		sbt run

		
