# ------------------------------------------------------------------------------
# Pull base image
FROM ubuntu:focal
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV LANG C
ENV DEBIAN_FRONTEND noninteractive
ENV NODEPKGURL https://nodejs.org/dist/v16.14.2/node-v16.14.2-linux-x64.tar.xz

# ------------------------------------------------------------------------------
# Install base and clean up
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential ca-certificates curl git locales && \
    sed -e 's/# en_US.UTF-8/en_US.UTF-8/' -i /etc/locale.gen && locale-gen && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install NodeJS and clean up
RUN curl -s ${NODEPKGURL} -o /tmp/node.tar.xz && \
    tar xf /tmp/node.tar.xz -C /opt/ && \
    rm /tmp/node.tar.xz && \
    mv /opt/node-* /opt/node && \
    ln -s /opt/node/bin/node /usr/bin/node && \
    ln -s /opt/node/bin/node /usr/bin/nodejs && \
    ln -s /opt/node/bin/npm /usr/bin/npm && \
    ln -s /opt/node/bin/npx /usr/bin/npx && \
    ln -s /opt/node/bin/corepack /usr/bin/corepack && \
    npm install -g npm@8.10.0

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 3000

# ------------------------------------------------------------------------------
# Define default command.
CMD ["tail", "-f", "/dev/null"]
