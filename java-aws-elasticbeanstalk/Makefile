build:
	mkdir output && mkdir target
	javac src/httpserver/* -d output
	jar cvfm target/server.jar Manifest.txt -C output/ . src/*
	wget "https://search.maven.org/remote_content?g=com.rookout&a=rook&v=LATEST"  -O rook.jar

run:
	export PORT=7000 && java -javaagent:rook.jar -jar target/server.jar

