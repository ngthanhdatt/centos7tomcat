#!/bin/sh

set -e

# check if the Tomcat product home exists
test ! -d ${TOMCAT_SERVER_HOME} && echo "Tomcat product home does not exist" && exit 1

# start TOMCAT server show log stdout
${TOMCAT_SERVER_HOME}/bin/startup.sh; tail -f ${TOMCAT_SERVER_HOME}/logs/catalina.out
