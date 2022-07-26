FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="wintergerst.stefan@googlemail.com"
LABEL name="stwgt-dev"
LABEL version="latest"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

RUN apt-get update && apt-get upgrade -y

RUN apt-get install git curl -y

ARG NODE_VERSION=v18.4.0

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN source /root/.nvm/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm alias default ${NODE_VERSION} \
    && nvm use default

ENV NODE_PATH /root/.nvm/${NODE_VERSION}/lib/node_modules
ENV PATH /root/.nvm/versions/node/${NODE_VERSION}/bin:$PATH

ARG PNPM_VERSION=7.5.1
ARG YARN_VERSION=1.22.19

RUN npm install --location=global pnpm@${PNPM_VERSION} yarn@${YARN_VERSION}

