#!/bin/bash
USER=$1
PASSWORD=$2


#BEFORE_DATE=$(date -Is)
BEFORE_DATE=$(date +%FT%TZ)

echo "Deleting old snapshots"
/enonic-xp/toolbox/toolbox.sh delete-snapshots -a $USER:$PASSWORD -b $BEFORE_DATE
echo "Taking new snapshot of indexes"
/enonic-xp/toolbox/toolbox.sh snapshot -a $USER:$PASSWORD