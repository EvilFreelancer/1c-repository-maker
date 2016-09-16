# 1C Repository Maker

A collection of scripts to create a repository of deb or rpm packages 1C.

## How to get and use

    git clone git@github.com:PavelRykov/1c-repository-maker.git
    cd 1c-repository-maker
    ./bin/1c.sh

After this the program starts to download files from the 1C site.

## Automate it

You can automate packages update via Cron, for example:

    # Update 1C packages
    0 0 * * * /opt/scripts/1c-repository-maker/bin/1c.sh

This example mean: "Run script every day at 0 hours 0 minutes", more details you can find on [Wikipedia](https://en.wikipedia.org/wiki/Cron#Overview).

## Nginx config example

    server {
    	listen 80;
    	server_name 1c.example.com;
    	root /path/to/repo;
    	charset utf8;
    	server_tokens off;
    
        location / {
            autoindex on;
            autoindex_exact_size off;
            autoindex_localtime on;
        }
    }

## Depends on

* bash
* wget
* dpkg-scanpackages
* createrepo
