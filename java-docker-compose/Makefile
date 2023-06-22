build-local-maven:

		#We download the javaagent for local running
		wget "https://search.maven.org/remote_content?g=com.rookout&a=rook&v=LATEST"  -O rook.jar

		#We need to build the tartget/rookoutDemo-1.0.0.jar - which already include the project sources in the jar
		mvn package

build-local-gradle:
		#We download the javaagent for local running
		wget "https://search.maven.org/remote_content?g=com.rookout&a=rook&v=LATEST"  -O rook.jar

		#We need to build the build/libs/rookoutDemo-1.0.0.jar - which already include the project sources in the jar
		gradle fatJar

build-for-docker-compose:
	#We need to build the tartget/rookoutDemo-1.0.0.jar that we later use in the dockerfile.
	mvn package

run-local-maven:
	#We need to add the javaagent to the run
	java  -javaagent:rook.jar -jar target/rookoutDemo-1.0.0.jar

run-local-gradle:
    java  -javaagent:rook.jar -jar build/libs/rookoutDemo-1.0.0.jar