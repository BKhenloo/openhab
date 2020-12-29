FROM registry.access.redhat.com/ubi8/ubi-minimal as SRC

ARG OPENHAB_SRC=https://bintray.com/openhab/mvn/download_file?file_path=org%2Fopenhab%2Fdistro%2Fopenhab%2F3.0.0%2Fopenhab-3.0.0.zip

RUN microdnf install --nodocs wget unzip \
 && wget -O /tmp/openhab-download.zip ${OPENHAB_SRC} \
 && unzip /tmp/openhab-download.zip -d /opt/openhab \
 && rm -f /tmp/openhab-download.zip 




FROM registry.access.redhat.com/ubi8/ubi-minimal

COPY --from=SRC /opt/openhab /opt/openhab

RUN microdnf install --nodocs sudo java-11-openjdk-headless shadow-utils \
 && adduser --no-create-home --user-group openhab \
 && chown -hR openhab:openhab /opt/openhab

EXPOSE 8080
WORKDIR /opt/openhab

ENTRYPOINT ["sudo", "-u", "openhab", "/usr/bin/bash", "-c", "/opt/openhab/start.sh"]
