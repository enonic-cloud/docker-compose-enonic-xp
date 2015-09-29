# Docker image for Enonic XP
This Docker Compose set builds upon the Enonic XP image from `enonic/xp-app` and includes the superhero module from [https://github.com/enonic/module-superhero-blog]() downloaded from the official enonic repository. Do use another version of enonic XP, please change the baseimage tag in `Dockerfile`

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


# Usefull links

- Using Docker-compose in production: https://docs.docker.com/compose/production/
- 