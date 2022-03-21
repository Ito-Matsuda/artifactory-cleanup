FROM ubuntu:20.04

USER root

ARG NOTROOTUSER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"
WORKDIR /home/$NOTROOTUSER
ENV GOPATH=/home/jovyan/go

# Install pre-requisites for running Docker in rootless mode and other utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      'jq' \
      'curl' \
      'wget' \
      'uidmap' \
      'dbus-user-session' \
      'ca-certificates' \
      'gnupg' \
      'lsb-release'\ 
      'git'

# Install kubectl
ARG KUBECTL_VERSION=v1.15.10
ARG KUBECTL_URL=https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
ARG KUBECTL_SHA=38a0f73464f1c39ca383fd43196f84bdbe6e553fe3e677b6e7012ef7ad5eaf2b

RUN curl -LO "${KUBECTL_URL}" \
    && echo "${KUBECTL_SHA} kubectl" | sha256sum -c - \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# Operate in non root
RUN useradd $NOTROOTUSER
ENV NOTROOTUSER="${NOTROOTUSER}" \
    NB_UID=${NB_UID} \
    NB_GID=${NB_GID}

#Install GO
ARG GO_VERSION=1.16.7
ARG GO_SHA=7fe7a73f55ba3e2285da36f8b085e5c0159e9564ef5f63ee0ed6b818ade8ef04
ARG CRANE_VERSION=v0.8.0

RUN curl -OL https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz \
    && echo "${GO_SHA} go$GO_VERSION.linux-amd64.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -xvf go$GO_VERSION.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

#Install Crane
RUN go install github.com/google/go-containerregistry/cmd/crane@$CRANE_VERSION

COPY 1-RuntimeScanning /home/$NOTROOTUSER
COPY run-job.sh /home/$NOTROOTUSER
RUN chmod -R 755 /home/$NOTROOTUSER
RUN chown -R $NOTROOTUSER /home/$NOTROOTUSER
USER $NOTROOTUSER

# docker run -it --rm --entrypoint /bin/bash test
CMD ["./run-job.sh"]
