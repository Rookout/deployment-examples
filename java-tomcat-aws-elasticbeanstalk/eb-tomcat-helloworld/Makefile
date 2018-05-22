local:
	wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O /Library/Tomcat/lib/rook.jar
	echo "set CATALINA_OPTS=-agentpath:/Library/Tomcat/lib/rook.jar" >> /Library/Tomcat/bin/setenv.sh