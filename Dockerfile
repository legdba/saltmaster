##############################################################
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
##############################################################
FROM ubuntu:16.04
MAINTAINER legdba <legdba@yahoo.com>

# Install Salt 2016.3 (latest stable version at time of writting)
RUN apt-get -q -y update && \
    apt-get -q -y upgrade && \
    apt-get -q -y install wget curl software-properties-common && \
    apt-get -q -y install python-software-properties && \
    wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/2016.3/SALTSTACK-GPG-KEY.pub | apt-key add - && \
    echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/2016.3 xenial main" | tee /etc/apt/sources.list.d/saltstack.list && \
    apt-get -q -y update && \
    apt-get -q -y install salt-api salt-cloud salt-master salt-minion salt-ssh salt-syndic && \
    rm -rf /var/lib/apt/lists/*

# Define volumes
# /etc/salt/pki - Salt Minion authentication keys
# /var/cache/salt - Job and Minion data cache
# /var/logs/salt - Salt log directory
# /etc/salt - States, pillars etc
VOLUME ["/etc/salt/pki", "/var/cache/salt", "/var/logs/salt", "/etc/salt"]

ENV LOG_LEVEL=${LOG_LEVEL:-"error"}

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

RUN /usr/local/bin/run.sh --version

EXPOSE 4505 4506
ENTRYPOINT ["/usr/local/bin/run.sh"]

RUN salt --version
