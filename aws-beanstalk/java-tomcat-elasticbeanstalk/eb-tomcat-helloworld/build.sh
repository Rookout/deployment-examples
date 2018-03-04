cd src
mkdir -p WEB-INF/classes
echo .
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/rookout/web/HelloWorld.java
echo .
jar -cf ROOT.war WEB-INF .ebextensions/*.config com
echo .
if [ -d "/Library/Tomcat/webapps" ]; then
  cp ROOT.war /Library/Tomcat/webapps
  echo .
fi
mv ROOT.war ../
echo .
echo "SUCCESS"
