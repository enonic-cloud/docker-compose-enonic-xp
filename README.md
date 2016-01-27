# Docker image for Enonic XP
This Docker Compose set builds upon the Enonic XP image from `enonic/xp-app`. To select witch version of enonic XP to use, please specify it in the  FROM tag in `exp/Dockerfile`

This setup also has a apache server in front and a mailserver configured for Enonic XP.

## Building the service
To build the service, clone this repo
```
git clone https://github.com/enonic-cloud/docker-compose-enonic-xp <instance name>
cd <instance name>
```

To configure the Instance automaticly, use the configure.sh script and replace "my-server.hostname.com" with your servers hostname. This will configure vhosts for both apache and Enonic XP. 
```
./configure.sh my-server.hostname.com
```

Edit the `exp/config/com.enonic.xp.web.vhost.cfg` and modify the `mapping.site.target` to point to your application.

Get rid of existing git files and initial config script.
````
rm -rf .git configure.sh
````


Now, build the container set with docker-compose
```
docker-compose build 
```

## Running the application
To run the application, simply run the following command after building the image as described above
```
$ docker-compose up -d 
```

## Redeploy changes
To redeploy changes to in the Enonic XP installation, just redeploy the affected containers ( and not the storage container ).
```
$ docker-compose build exp apache2
$ docker-compose stop exp apache2
$ docker-compose rm exp apache2
$ docker-compose up --no-deps -d exp apache2
```

## Toolbox dump
Dump the container and copy the dump to your local machine
```
XPCONTAINER=<your xp container>
XP_SU_PWD=<put your su password here>
XP_REPO_TARGET=<repo dump>
XP_TMP=/tmp/$XPCONTAINER

mkdir $XP_TMP
docker exec $XPCONTAINER /enonic-xp/toolbox/toolbox.sh dump -a su:$XP_SU_PWD -t $XP_REPO_TARGET
docker cp $XPCONTAINER:/enonic-xp/home/data/dump/$XP_REPO_TARGET $XP_TMP/.
```

## Toolbox restore
To restore a dump, you need a fresh installation of Enonic XP. If you you have other containers in your setup, please specify the Enonic XP containers when you do the `docker-compose rm` command.
```
XPCONTAINER=<your xp container>
XP_REPO_TARGET=<repo dump>
XP_TMP=/tmp/$XPCONTAINER
docker-compose rm   # Deletes all containers
docker-compose up -d   # Starts up a fresh set
docker exec $XPCONTAINER mkdir -p enonic-xp/home/data/dump   # Creates the dump directory
docker cp $XP_TMP/$XP_REPO_TARGET $XPCONTAINER:/enonic-xp/home/data/dump/.    # Copies over already dumped repo
docker exec $XPCONTAINER /enonic-xp/toolbox/toolbox.sh load -a su:password -s $XP_REPO_TARGET   # Does a toolbox import of the exported repo
```

## Upgrading
Upgrade Enonic xp, build the container set and copy over files
- First, check the upgrade notes for Enonic XP for the versions between your current version and the one you wan't to use. you can find the latest ones here: [http://xp.readthedocs.org/en/stable/appendix/upgrade/index.html]
- Change the xp-app version number in exp/Dockerfile
- Then do a `docker-compose build` to build the new set of containers
- Redeploy changes as describe above

## Upgrading a installation that requires a toolbox dump and load
Sometimes an upgrade requires a toolbox dump and load to fix some changes i the data model. The upgrade task in itself will be a little different.
- Make shure you have a working backup of your installation. 
- Do a toolbox dump of the installation.
- Build your docker containers with `docker-compose build`.
- Then instead of redeploying your running containers, delete them all with the command `docker-compose rm`.
- Start up a clean Installation with the command `docker-compose up -d`.
- Import you old installation with toolbox load command above.


# Usefull links
- Using Docker-compose in production: https://docs.docker.com/compose/production/

