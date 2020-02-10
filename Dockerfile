FROM alpine/terragrunt:0.12.20

ARG TERRAGRUNT

RUN apk add --update --no-cache bash git openssh build-base python3 ansible
#Print Version
RUN python3 --version
RUN pip3 --version
RUN ansible --version
RUN pip3 install --no-cache boto3==1.9.240
#Print PIP3 Version
RUN pip3 list

RUN chmod +x /usr/local/bin/terragrunt

WORKDIR /apps

ENTRYPOINT []
