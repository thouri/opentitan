# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

FROM ubuntu:22.10

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    fonts-freefont-ttf locales locales-all \
    git curl \
    doxygen hugo xsltproc \
    python3 python3-pip \
    gcc libc-dev

ENV LC_ALL "en_US.UTF-8"
ENV LANG "en_US.UTF-8"
ENV LANGUAGE en_US:en

RUN mkdir -p /tools

##############
### python ###
##############

# Explicitly updating pip and setuptools is required to have these tools
# properly parse Python-version metadata, which some packages uses to
# specify that an older version of a package must be used for a certain
# Python version. If that information is not read, pip installs the latest
# version, which then fails to run.
COPY python-requirements.txt ./
ENV PATH "/root/.local/bin:${PATH}"
RUN python3 -m pip install -U pip "setuptools<66.0.0" \
  && pip3 install -r python-requirements.txt



# Make /tools accessible to everyone
RUN chmod -R a+rwX /tools
# Cleanup
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
