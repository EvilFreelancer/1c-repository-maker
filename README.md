# 1C Thin Client Repository Maker

A collection of scripts to create a repository of deb or rpm packages 1C thin client.

## How to get and use

    git clone git@github.com:EvilFreelancer/1c-repository-maker.git
    cd 1c-repository-maker
    ./bin/1c.sh

After this the program starts to download files from the 1C site.

## Automate it

You can automate packages update via Cron, for example:

    # At first need to remove old packages (first arg - mode, second - count of saved packages, i recommend minimum 8)
    0 0 * * * /opt/scripts/1c-repository-maker/bin/cleaner.sh deb 8
    0 0 * * * /opt/scripts/1c-repository-maker/bin/cleaner.sh rpm 8

    # Update 1C packages
    0 1 * * * /opt/scripts/1c-repository-maker/bin/1c.sh

__Warning: Absolute path is important!__

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
* dpkg-scanpackages (from dpkg-dev)
* createrepo
* gzip

Command for installing of all dependencies on Debian/Ubuntu:

    apt-get install bash wget dpkg-dev createrepo gzip

## Some links

* [Download page of 1C thin client](https://1cfresh.com/articles/thin_install_linux)
* [Working repository with 1C packages](http://1c.drteam.rocks/)
