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

#Some issue here rn
#RUN curl -LO "${KUBECTL_URL}" \
#    && echo "${KUBECTL_SHA} kubectl" | sha256sum -c - \
#    && chmod +x ./kubectl \
#    && sudo mv ./kubectl /usr/local/bin/kubectl


#COPY fix-permissions /usr/local/bin/fix-permissions
#RUN chmod a+rx /usr/local/bin/fix-permissions

COPY 1-RuntimeScanning /home/$NOTROOTUSER

# Operate in non root
RUN useradd $NOTROOTUSER
ENV NOTROOTUSER="${NOTROOTUSER}" \
    NB_UID=${NB_UID} \
    NB_GID=${NB_GID}

#RUN apt-get update && \
#    apt-get install -y --no-install-recommends \
#      'kmod' \
#      'iptables'



#Install GO
RUN curl -OL https://golang.org/dl/go1.16.7.linux-amd64.tar.gz \
    && tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
RUN go install github.com/google/go-containerregistry/cmd/crane@v0.8.0

RUN ls
RUN echo $GOPATH/bin
# Install Crane
#ARG CRANE_VERSION=v0.8.0
#ARG CRANE_URL=https://github.com/google/go-containerregistry/releases/download/${CRANE_VERSION}/go-containerregistry_Linux_arm64.tar.gz

#RUN wget "${CRANE_URL}" \
#    && tar zxf go-containerregistry_Linux_arm64.tar.gz -C /usr/bin


# docker run -it --rm --entrypoint /bin/bash test
CMD ["echo", "Hello World"]
