FROM alpine/terragrunt:0.12.20

ARG TERRAGRUNT

RUN apk add --update --no-cache bash git openssh python3
RUN pip3 install --no-cache ansible==2.5 boto3==1.9.240

RUN chmod +x /usr/local/bin/terragrunt

WORKDIR /apps

ENTRYPOINT []
