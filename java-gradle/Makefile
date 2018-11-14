build:
    	#We download the javaagent for local running
	wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar

    	#We need to build the build/libs/rookoutDemo-1.0.0.jar - which already include the project sources in the jar
	gradle fatJar

gradle-run:
	export ROOKOUT_TOKEN=$(token)
	gradle run

