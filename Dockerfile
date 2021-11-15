FROM hashicorp/terraform:$TERRFORM_VERSION as terragrunt_build
LABEL maintainer="Devops Perion <devops@perion.com>"
ENV TERRFORM_VERSION=${TERRFORM_VERSION:-0.12.30}
ENV TERRAGRUNT_VERSION=${TERRAGRUNT_VERSION:-0.24.4}
ENV KUBECTL_VERSION="v1.19.10"
ADD https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 /usr/local/bin/terragrunt

RUN apk add --no-cache \
        bash \
        py3-pip \
        git \
        openssh \
        build-base \
        python3 \
        curl \
        ansible \
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
