FROM ubuntu:20.04

WORKDIR /home/cleanup

#Install utilities here
RUN apt-get update --yes &&\
    apt-get install -y \
    'jq' \
    'curl' \
    'wget' \ 
    'ssmtp' \
    'mailutils' \
    'postgresql-client-common' \
    'postgresql-client-12'

#Postgresql both packages required to use psql CLI (though additional config may be needed.)
# as in i installed both on my personal and tried using it out of box to failure
#Will I need to have it run kubectl port-forward???? but how do I achieve that 

#yq https://github.com/mikefarah/yq/releases/download/v4.9.3/yq_linux_amd64
ARG YQ_VERSION=4.9.3
RUN wget https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq

#kubectl
ARG KUBECTL_VERSION=v1.15.10
ARG KUBECTL_URL=https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
ARG KUBECTL_SHA=38a0f73464f1c39ca383fd43196f84bdbe6e553fe3e677b6e7012ef7ad5eaf2b
RUN curl -LO "${KUBECTL_URL}" \
    && echo "${KUBECTL_SHA} kubectl" | sha256sum -c - \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl


#Copy files here
COPY resources/1-get-old-images .
COPY resources/2-images-used-in-cluster .
COPY resources/3-list-images-to-delete .
COPY resources/4-get-vulnerable . 
COPY resources/5-compare-vulnerabilities .
COPY resources/6-get-new-notebook-img .
COPY resources/7-patch-or-delete-notebook .
COPY resources/g-send-email . 
COPY resources/x-delete-from-artif . 
COPY run-job.sh . 

#Configure SMTP (by copying file)
RUN mv ssmtp.conf /etc/ssmtp/

# Grant files execute here
RUN chmod +x run-job.sh

RUN find ./ -type f -iname "*.sh" -exec chmod +x {} \;

CMD ./run-job.sh
#This CMD is overwritten by the CRON command anyways