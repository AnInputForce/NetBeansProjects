#!/bin/bash
JAVA_HOME="/usr/lib/jdk"
JAVA_BIN="/usr/lib/jdk/bin"
PATH="$JAVA_HOME:$JAVAV_BIN:$PATH:$JAVA_HOME/bin"
CLASSPATH=".:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"
export JAVA_HOME JAVA_BIN PATH CLASSPATH
cd /home/weblogic103/webmonitor/
java -jar loanserver.jar

#echo aaaaaaaaa
