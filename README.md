# docker-compose-phpfpm-nginx-mysql
[![Build Status](https://travis-ci.org/yeclense/docker-compose-phpfpm-nginx-mysql.svg?branch=master)](https://travis-ci.org/yeclense/docker-compose-phpfpm-nginx-mysql)

docker-compose devenv setup ready to start building a Symfony application. Can work with any other php app too.

## Setup

You can use your own `.env` file, just copy the variables in`.env.dist` to it. This command will create a `.env` for you if you don't have one already:

``cp -n .env.dist .env``

## Run

To spin up you devenv just run:

``make``

## Stop and remove containers
To stop devenv and remove its containers:

``make nodev``