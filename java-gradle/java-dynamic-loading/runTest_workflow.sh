unset JAVA_TOOL_OPTIONS
export JAVA_TOOL_OPTIONS=""
java -jar /build/libs/rookoutDemo-1.0.0.jar &
export ROOKOUT_TARGET_PID=$(ps -ef | grep 'java -jar /build/libs/rookoutDemo-1.0.0.jar' | grep -v grep | awk '{print $2}') 
java -jar $ROOK_DEST/rook-all.jar &
