FROM alpine/terragrunt:1.4.4
# tg version 0.45.0, tf version 1.4.4
LABEL maintainer="Devops Perion <devops@perion.com>"
ENV KUBECTL_VERSION="v1.23.14"
RUN apk add --no-cache \
                bash \
                jq \
                git \
                openssh \
                build-base \
                curl \
                unzip \
         && chmod +x /usr/local/bin/terragrunt \
         && rm -rf /var/cache/apk/* \
         && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
         && chmod +x /usr/local/bin/kubectl \
         && mkdir -p /root/.kube/ \
         && touch –a /root/.kube/config  \
         && curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash


# Install aw-cli

ENV GLIBC_VER=2.35-r0
ENV AWSCLI_VERSION=2.9.0

# install glibc compatibility for alpine
RUN apk --no-cache add \
        binutils \
        curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-i18n-${GLIBC_VER}.apk \
    # --force-overwrite to resolve error failing build "glibc-2.35-r0: overwriting etc/nsswitch.conf owned by alpine-baselayout-data-3.2.0-r23"
    && apk add --no-cache --force-overwrite \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
        glibc-i18n-${GLIBC_VER}.apk \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && ln -sf /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2 \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/current/dist/aws_completer \
        /usr/local/aws-cli/v2/current/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/current/dist/awscli/examples \
        glibc-*.apk \
    && find /usr/local/aws-cli/v2/current/dist/awscli/botocore/data -name examples-1.json -delete \
    && apk --no-cache del binutils \
    && rm -rf /var/cache/apk/*

WORKDIR /apps
ENTRYPOINT ["/bin/bash"]
