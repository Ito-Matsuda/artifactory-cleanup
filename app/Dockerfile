FROM ubuntu:20.04

RUN apt-get update -y \
    && apt-get install -y python3 python3-pip \
    && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/pip3 /usr/bin/pip \
    && pip install --upgrade pip

#Pretty sure I need kubectl here (need to use to query all images in use). 
ARG KUBECTL_VERSION=v1.15.10
ARG KUBECTL_URL=https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
ARG KUBECTL_SHA=38a0f73464f1c39ca383fd43196f84bdbe6e553fe3e677b6e7012ef7ad5eaf2b

RUN curl -LO "${KUBECTL_URL}" \
    && echo "${KUBECTL_SHA} kubectl" | sha256sum -c - \
    && chmod +x ./kubectl \
    && sudo mv ./kubectl /usr/local/bin/kubectl

RUN useradd -m app
USER app
WORKDIR /home/app

#For now just 'requests' check if needed (maybe just need curl)
COPY --chown=app:app requirements.txt requirements.txt
RUN pip install --user -r requirements.txt

ENV PATH="/home/app/.local/bin:${PATH}"

COPY --chown=app:app . .

CMD ["python3", "main.py"]