#!/bin/bash
set -x
MYHOME="/some/dir"
cd ${HOME}

md5sum web/cve/index.html > ./md5sum.out

source venv/bin/activate
source env.txt

python cve-feed.py

md5sum -c ./md5sum.out
if [[ ! $? -eq 0 ]]; then
    echo "sending slack message!"
    python cve-SendToSlack.py
fi

