solr
====

Production-ready maven project for Solr projects. The output of this build is an installation archive containing
some handy defaults as well as some utility scripts.

Configure
=========
You can setup solr configurations here:

[Click here to see the Solr configuration folder](https://github.com/vast-eng/solr/tree/master/src/main/config)


Install 
=======
The build process generates a tarball suitable for installation. This archive contains a default config,
some reasonable start/stop scripts, and a logging config. This is really intended only as a boilerplate - if your
needs are different, you should either create a new assembly descriptor or just fork and customize this repo.

Start Server
============

Uncompress the installation tarball somewhere, and use the start/stop scripts.

*Start*
```
sh start.sh
```

With default settings, your server will be running on the Solr default port 8983.  

[Solr Back Office - http://localhost:8983/solr](http://localhost:8983/solr)

*Stop*
```
sh stop.sh
```