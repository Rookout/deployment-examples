build:
    #We download the javaagent for local running
	wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar

	#We need to build the tartget/rookoutDemo-1.0.0.jar - which already include the project sources in the jar
	mvn package

run:
	#We need to add the javaagent to the run
	java  -javaagent:rook.jar -jar target/rookoutDemo-1.0.0.jar
