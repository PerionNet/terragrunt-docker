FROM alpine/terragrunt:0.12.20
LABEL maintainer="Perion DevOps <DevOps@Perion.com>"

ARG TERRAGRUNT
ENV KUBECTL_VERSION="v1.15.10"
ENV AWS_IAM_ATHU="0.5.0"

RUN apk add --update --no-cache bash git openssh build-base python3 ansible curl \
    && python3 --version \
    && pip3 --version \
    && ansible --version \
    && pip3 install --no-cache boto3==1.9.240 \
    && pip3 list \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && mkdir -p /root/.kube/ \
    && touch –a /root/.kube/config \
    && kubectl version --client \
    && curl -L https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${AWS_IAM_ATHU}/aws-iam-authenticator_${AWS_IAM_ATHU}_linux_amd64 -o /usr/local/bin/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator \
    && aws-iam-authenticator version \
    && chmod +x /usr/local/bin/terragrunt
WORKDIR /apps

ENTRYPOINT []