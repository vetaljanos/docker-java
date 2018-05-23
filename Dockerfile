FROM ubuntu:18.04

ENV JAVA_VERSION=7 \
    JAVA_UPDATE=80 \
    JAVA_BUILD=15 \
    JAVA_HOME="/usr/lib/jvm/default-jvm"

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install ca-certificates curl unzip -y --no-install-recommends 

ADD jdk.zip /tmp/

RUN mkdir -p "/usr/lib/jvm/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" \
  && unzip -d "/usr/lib/jvm/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" /tmp/jdk.zip \
  && ln -s "/usr/lib/jvm/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "$JAVA_HOME" \
  && chmod 755 $JAVA_HOME/bin/* \
  && chmod 755 $JAVA_HOME/jre/bin/* \
  && apt-get autoclean && apt-get --purge -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
  update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 1 && \
  update-alternatives --set java "${JAVA_HOME}/bin/java" && \
  update-alternatives --set javaws "${JAVA_HOME}/bin/javaws"
