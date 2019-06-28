FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive \
  SSH_ADDITIONAL_OPTIONS='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o IdentityFile=/ssh-identity'

RUN apt-get update -qq && \
    apt-get install -y openssh-client \
      ssg-base \
      ssg-debian \
      ssg-debderived \
      ssg-nondebian \
      ssg-applications \
      wget && \
    adduser --gecos "SCAP policy user" \
      scapadm --disabled-password \
      --home /var/lib/scapadm && \
    wget https://raw.githubusercontent.com/OpenSCAP/openscap/maint-1.3/utils/oscap-ssh && \
    chmod 0755 oscap-ssh && \
    mv oscap-ssh /usr/local/bin/oscap-ssh && \
    chown root:root /usr/local/bin/oscap-ssh && \
    cp /usr/share/scap-security-guide/ssg-ubuntu1604-cpe-dictionary.xml /usr/share/openscap/cpe/openscap-cpe-dict.xml && \
    cp /usr/share/scap-security-guide/ssg-ubuntu1604-cpe-oval.xml /usr/share/openscap/cpe/openscap-cpe-oval.xml && \
    apt-get remove -y wget && apt-get clean

USER scapadm
ENTRYPOINT ["/usr/local/bin/oscap-ssh"]
