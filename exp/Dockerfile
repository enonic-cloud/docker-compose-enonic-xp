FROM enonic/xp-app:6.6.0

# Set Memory settings
# Defaults to 1/4 of servers physical mem
#ENV JAVA_OPTS "-Xms1024M -Xmx2048M"

USER root

RUN cp -r $XP_ROOT/home.org $XP_ROOT/home

###############################################################################
#    Insert commands to place Enonic XP application in deploy folder here.    #
###############################################################################

# Either place the compiled jar file in the deploy folder...
COPY deploy/* $XP_ROOT/home/deploy/

# Or download it from an alternative source on the net.
#ENV SUPERHERO_VERSION 1.0.0
#RUN wget -O $XP_ROOT/home/deploy/superhero-$SUPERHERO_VERSION.jar http://repo.enonic.com/public/com/enonic/app/superhero/$SUPERHERO_VERSION/superhero-$SUPERHERO_VERSION.jar


###############################################################################

COPY config/* $XP_ROOT/home/config/

COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

RUN mkdir $XP_ROOT/home/repo
RUN chown enonic-xp -R $XP_ROOT/home

USER enonic-xp
