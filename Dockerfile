FROM debian:10 as builder

COPY java8.tar.gz /
RUN tar -zxf /java8.tar.gz && rm -rf /java8.tar.gz

FROM debian:10

ENV JAVA_VERSION=8 \
    JAVA_HOME="/usr/lib/jvm/java8" \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install ca-certificates -y --no-install-recommends

COPY --from=builder /java8 $JAVA_HOME
