build:
	mkdir output && mkdir target
	javac src/httpserver/* -d output
	jar cvfm target/server.jar Manifest.txt -C output/ . src/*
	wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar

run:
	java -javaagent:rook.jar -jar target/server.jar

