# Based on debian
FROM debian

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      unzip \
      build-essential \
      ruby \
      ruby-dev \
      gettext \
      python-pip \
      jq \
      git \
      curl \
      openjdk-11-jre

ARG BIN_PATH=/usr/local/bin
ARG GIT_URL=THE_GIT_URL

RUN mkdir ~/.ssh \
&& echo "Host ${GIT_URL}\n    StrictHostKeyChecking=no\n    UserKnownHostsFile=/dev/null" > ~/.ssh/config \
&& echo "nameserver 8.8.8.8" > /etc/resolv.conf

COPY scripts /scripts

RUN mv /scripts/* ${BIN_PATH}/ \
&& chmod +x ${BIN_PATH}/versiontag*

## Install Terraform
ARG TERRAFORM_VERSION=0.12.21
RUN curl -s \
      https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
      -o ${BIN_PATH}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip  && \
    cd ${BIN_PATH} && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

## Install Inspec
## Latest verision of inpec = 4.18.97
ARG INSPEC_VERSION=4.18.97
RUN gem install --no-document  --version "${INSPEC_VERSION}" inspec
RUN gem install --no-document  --version "${INSPEC_VERSION}" inspec-bin


## Install Terragrunt
ARG TERRAGRUNT_VERSION=0.22.5
ENV TERRAGRUNT_TFPATH=${BIN_PATH}/terraform
RUN curl -sL https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 \
    -o ${BIN_PATH}/terragrunt && chmod +x ${BIN_PATH}/terragrunt

## Install AWS-CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
&& unzip awscliv2.zip \
&&  ./aws/install


## Install  SHUNIT2
RUN curl -sL https://raw.githubusercontent.com/kward/shunit2/master/shunit2 -o ${BIN_PATH}/shunit2 \
&& chmod +x ${BIN_PATH}/shunit2

## Install gitchangelog
RUN pip install gitchangelog

## Clean
RUN rm -Rf awscliv2.zip aws \
&& apt-get clean
