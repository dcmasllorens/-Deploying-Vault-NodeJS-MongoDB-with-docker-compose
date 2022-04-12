# Deploying-Vault-NodeJS-MongoDB-with-docker-compose

In this repository, we will know how to deploy NodeJS MongoDB and Vault with Docker-Compose, this repo is related with [this one](https://github.com/Cybersecurity-Montilivi/Using-ExpressJS-with-Docker-MongoDB) because the image downloads the node JS API repo and after starts. 

The target of this repo is start a demo for how to start a docker-compose with some services, we are deploying the VAULT in DEV mode, that means you can't deploy this vault in PRODUCTION. If you w'ant to deploy the Vault in PROD you need to configure TLS, certificates, how to unseal automatically when you start the service and more configurations.

### Starting services

For starting the all containers on background, we will use this command, for view the all logs of containers we will use the command without the parameter -d.

~~~
docker-compose up -d
~~~

### SETTING ENVIRONMENT VARIABLES 

Here we have an example of .env, this file is so important to configure, we will put this file in the same directory as **docker-compose.yml**, 

~~~
MONGO_INITDB_ROOT_USERNAME=
MONGO_INITDB_ROOT_PASSWORD=
~~~

### Configuring MongoDB user
Remember in this case we don't have persistence with information data ,

When we run a container with mongo, docker automatically assign an ip addres to this container. We will use docker inspect to know the IP.

~~~~
docker inspect CONTAINER_ID | grep "IPAddress"
~~~~

When we know the IP Adress we will connect with a [mongosh](https://docs.mongodb.com/mongodb-shell/)

If we want to see the databases of MongoDB we need to authenticate with user that we put in *docker-compose.yml*
For [connect with mongosh](https://docs.mongodb.com/mongodb-shell/connect/#std-label-mdb-shell-connect) we need the docker container IP address

~~~~
mongosh "mongodb://<docker container ip>" --username <user admin> --password <password>
~~~~

After this, we will do a show db, and we will see the 3 default databases.

~~~
show dbs
~~~

### Creating database user
Authenticated with mongoosh we will create database users
~~~
use users
~~~

We need to stay connected with mongosh into a mongoDB. We will execute this command for creating a user for this database.

~~~~
db.createUser({ user: "superadmin", pwd: "superadmin", roles: [{ role: "readWrite", db: "users" }] })
~~~~

After this we will connect with this new user
~~~~
mongosh "mongodb://<docker container ip>" --username <user admin> --password <password> --authenticationDatabase users
~~~~
