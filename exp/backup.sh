#!/bin/bash

# Returns exit code 0 if there are a snapshot thats newer than 1440 minutes ( 24h ).
echo "Found the following snapshots:"
eval find /enonic-xp/home/snapshots/  -maxdepth 1 -cmin -1440 -iname 'snapshot*' -type f | egrep '.*'
