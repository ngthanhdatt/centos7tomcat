# set base Docker image to AdoptOpenJDK CentOS Docker image
FROM adoptopenjdk/openjdk8:x86_64-centos-jdk8u282-b08

# set Docker image build arguments
# build arguments for user/group configurations
ARG USER_ID=0
ARG WORK_DIR=/opt

# build arguments for TOMCAT product installation
ARG TOMCAT_SERVER_NAME=apache-tomcat
ARG TOMCAT_SERVER_VERSION=9.0.50
ARG TOMCAT_SERVER=${TOMCAT_SERVER_NAME}-${TOMCAT_SERVER_VERSION}
ARG TOMCAT_SERVER_HOME=${WORK_DIR}/${TOMCAT_SERVER}

# copy init script & source to work dir
RUN mkdir -p ${WORK_DIR}/${TOMCAT_SERVER}
COPY docker-entrypoint.sh ${WORK_DIR}/
RUN chmod a+x ${WORK_DIR}/docker-entrypoint.sh
COPY ${TOMCAT_SERVER} ${WORK_DIR}/${TOMCAT_SERVER}
RUN chmod a+x ${WORK_DIR}/${TOMCAT_SERVER}/bin/*.sh

# set the user and work directory
USER ${USER_ID}
WORKDIR ${WORK_DIR}

# set environment variables
ENV WORKING_DIRECTORY=${WORK_DIR} \
    TOMCAT_SERVER_HOME=${TOMCAT_SERVER_HOME}

# expose ports
EXPOSE 443

# initiate container and start Tomcat server
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
