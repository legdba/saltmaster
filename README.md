[![License Apache](https://www.brimarx.com/pub/apache2.svg)](http://www.apache.org/licenses/LICENSE-2.0)
# Usage
Run Salt Master, with labelled volumes, except for the data volume (states, pillars) that are in /srv/salt
```
docker run -v salt-master-pki:/etc/salt/pki -v salt-master-cache:/var/salt/cache -v salt-master-logs:/var/logs/salt -v /srv/salt:/etc/salt --rm -it --name saltmaster -p 4505:4505 -p 4506:4506 -e LOG_LEVEL=info saltmaster
```

Then ```docker exec``` salt commands as usual.
Examples:
```
alias salt="docker exec -ti saltmaster"
salt salt-cloud --list-providers
salt salt '*' test.ping
```

# License
This software is under Apache 2.0 license.
```
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
