FROM alpine/terragrunt:1.0.11
LABEL maintainer="Devops Perion <devops@perion.com>"
ENV KUBECTL_VERSION="v1.19.10"
RUN apk add --no-cache \
                bash \
                jq \
                git \
                openssh \
                build-base \
                python3 \
                curl \
 
         && chmod +x /usr/local/bin/terragrunt \
         && rm -rf /var/cache/apk/* \
         && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
         && chmod +x /usr/local/bin/kubectl \
         && mkdir -p /root/.kube/ \
         && touch –a /root/.kube/config 


# Install aw-cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \ 
    ./aws/install &&\ 
    rm -rf awscliv2.zip aws

WORKDIR /apps
ENTRYPOINT ["/bin/bash"]
