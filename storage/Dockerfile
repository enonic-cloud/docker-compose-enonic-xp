FROM busybox

MAINTAINER Erik Kaareng-sunde <esu@enonic.com>

RUN mkdir -p /enonic-xp/home/repo && mkdir -p /enonic-xp/home/work && mkdir -p /enonic-xp/home/snapshots
RUN adduser -h /enonic-xp/ -H -u 1337 -D -s /bin/sh enonic-xp
RUN chown -R enonic-xp /enonic-xp/
VOLUME /enonic-xp/home/repo /enonic-xp/home/work /enonic-xp/home/snapshots
ADD logo.txt /logo.txt
CMD cat /logo.txt
