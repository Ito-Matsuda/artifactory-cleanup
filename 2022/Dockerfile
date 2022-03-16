FROM ubuntu:20.04

USER root

ARG NOTROOTUSER="nonroot"
WORKDIR /home/$NOTROOTUSER

# Install pre-requisites for running Docker in rootless mode
# newuidmap and newgidmap may be ok

#Install Docker
#RUN sudo apt update -y \
#    && sudo apt install apt-transport-https ca-certificates curl software-properties-common \
#    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
#    && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" \
#    && sudo apt install docker-ce \
#    && sudo usermod -aG docker ${NOTROOTUSER}
### HMMM. this seems a bit annoying / tough in terms of doing so securely...
# https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo
# Use rootless mode https://docs.docker.com/engine/security/rootless/


# Install kubectl
ARG KUBECTL_VERSION=v1.15.10
ARG KUBECTL_URL=https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
ARG KUBECTL_SHA=38a0f73464f1c39ca383fd43196f84bdbe6e553fe3e677b6e7012ef7ad5eaf2b

RUN curl -LO "${KUBECTL_URL}" \
    && echo "${KUBECTL_SHA} kubectl" | sha256sum -c - \
    && chmod +x ./kubectl \
    && sudo mv ./kubectl /usr/local/bin/kubectl

COPY 1-RuntimeScanning /home/$NOTROOTUSER

# Operate in non root
RUN useradd -u 1996 $NOTROOTUSER
USER $NOTROOTUSER

# docker run -it --entrypoint /bin/bash [docker_image]
CMD ["echo", "Hello World"]