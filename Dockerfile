FROM registry.access.redhat.com/ubi8/ubi-minimal as SRC

ARG OPENHAB_SRC=https://bintray.com/openhab/mvn/download_file?file_path=org%2Fopenhab%2Fdistro%2Fopenhab%2F3.0.0%2Fopenhab-3.0.0.zip

RUN microdnf install --nodocs wget unzip tar shadow-utils \
 && wget -O /tmp/openhab-download.zip ${OPENHAB_SRC} \
 && unzip /tmp/openhab-download.zip /opt/openhab \
 && tar cfv - /opt/openhab | gzip -9 /tmp/openhab.tar.gz




FROM registry.access.redhat.com/ubi8/ubi-minimal
 
COPY --from=SRC /tmp/openhab.tar.gz /tmp/openhab.tar.gz
COPY start.sh /usr/local/sbin/start.sh

RUN microdnf install --nodocs java-11-openjdk-headless shadow-utils sudo \
 && mkdir -p /opt/openhab \
 && chmod +x /usr/local/sbin/start.sh

EXPOSE 8080
WORKDIR /opt/openhab
VOLUME ["/opt/openhab"]

ENV UID=1000
ENV GID=1000

ENTRYPOINT ["/usr/bin/env", "bash", "/usr/local/sbin/start.sh"]
