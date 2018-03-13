cd src
mkdir -p WEB-INF/classes
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/rookout/web/HelloWorld.java
jar -cf ROOT.war WEB-INF .ebextensions/*.config com
if [ -d "/Library/Tomcat/webapps" ]; then
  cp ROOT.war /Library/Tomcat/webapps
fi
mv ROOT.war ../
echo "SUCCESS"
