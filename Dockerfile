FROM alpine/terragrunt:1.0.0
LABEL maintainer="Devops Perion <devops@perion.com>"
ENV KUBECTL_VERSION="v1.19.10"
RUN apk add --no-cache \
        bash \
        py3-pip \
        git \
        openssh \
        build-base \
        python3 \
        curl \
 &&  /usr/bin/pip3 install --upgrade \
        pip \
        awscli \
 && chmod +x /usr/local/bin/terragrunt \
 && rm -rf /var/cache/apk/* \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && mkdir -p /root/.kube/ \
 && touch –a /root/.kube/config 
WORKDIR /apps
ENTRYPOINT ["/bin/bash"]
