# Docker file to create a container for running JUnit 4 tests with Java 25.
# Will install the Temurin version of Java 25 and Junit 4 package for Ubuntu:22.04.
#
# To build this file execute (including "." at the end): 
# docker build --file="java_and_java-junit.docker" --tag="cobo/java8-junit4" --rm=true .
#
# Note: we're only using a single RUN command to minimize the number of layers
# that Docker will create (every RUN commands creates a new layer). Commands are
# conncatenated with && and a new line is indicated with \
#
#

# all compilers run on cobo/ubuntu (make sure you've build that one already)
FROM cobo/ubuntu

RUN \
  apt-get update && \
  # install build tools + junit4
  apt-get install -y wget apt-transport-https gnupg junit4 locales && \
  # get and add the Adoptium GPG key and repository
  wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add - && \
  echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
  apt-get update && \
  # install Temurin JDK 25
  apt-get install -y temurin-25-jdk

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
