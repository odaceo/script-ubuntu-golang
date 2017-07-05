#!/bin/bash

# Copyright (C) 2017 Odaceo. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Init variables
GOLANG_WORKSPACE=${1:-'/home/vagrant'}
GOLANG_VERSION=${2:-'1.8.3'}

# Check preconditions
if [ -z "${GOLANG_WORKSPACE}" ]; then
    echo 'The workspace location is required to set the GOPATH environment variable.'
    exit 1
fi

# Download the archive
wget https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz

# Extract it into /usr/local, creating a Go tree in /usr/local/go
sudo tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz

# Configure the user environment
echo 'export GOROOT="/usr/local/go"'                | tee -a ~/.bash_profile
echo "export GOPATH=\"${GOLANG_WORKSPACE}\""        | tee -a ~/.bash_profile
echo 'export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"'  | tee -a ~/.bash_profile

# Init the user environment
source ~/.bash_profile

# Install a linter for Go source code
sudo go get github.com/golang/lint/golint
