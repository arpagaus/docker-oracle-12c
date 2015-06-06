#!/bin/bash

date
sudo -u oracle bash -c "cd /tmp/install/database/ && ./runInstaller -ignoreSysPrereqs -ignorePrereq -silent -waitforcompletion -noconfig -responseFile /tmp/db_install.rsp"

