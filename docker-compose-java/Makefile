build-maven:
	#First we need to create our app jar, It's important to include the source inside the jar
    # <plugin>
    #	<groupId>org.apache.maven.plugins</groupId>
    #    <artifactId>maven-source-plugin</artifactId>
    #    <version>2.2.1</version>
    #        <executions>
    #    	    <execution>
    #                <id>attach-sources</id>
    #                <phase>verify</phase>
    #                <goals>
    #                    <goal>jar-no-fork</goal>
    #                </goals>
    #            </execution>
    #        </executions>
    #	</plugin>	
	mvn package
	#Second we build the docker -Important to download the rook.jar as part of the docker build
	#RUN wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
	docker build .

run:
	#In order 
