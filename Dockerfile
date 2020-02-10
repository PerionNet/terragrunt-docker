FROM alpine/terragrunt:0.12.20

ARG TERRAGRUNT

RUN apk add --update --no-cache bash git openssh ansible

RUN chmod +x /usr/local/bin/terragrunt

WORKDIR /apps

ENTRYPOINT []