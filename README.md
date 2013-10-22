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
There are a number of params that can be sent to this startup script

* SOLR_PORT: the port for this instance of solr to listen.
* SOLR_DATA_DIR: path to the location for storing the index files.

Replication env params
* SOLR_MASTER: (true|false) if true, then this server is the master.  If not true, then this server is a slave.   It is best practice to always set this param.
* SOLR_MASTER_HOST: the host/post of the replication master

Examples:  
Run solr on port 9000, store files in /var/solr/index0, set as master for replication 

```
SOLR_PORT=9000 SOLR_MASTER=true SOLR_DATA_DIR=/var/solr/index0 sh start.sh
```

Run solr on port 9001, store files in /var/solr/index1, set as slave for replication, set master as the instance in the example above

```
SOLR_PORT=9001 SOLR_MASTER=false SOLR_MASTER_HOST=localhost:9000 SOLR_DATA_DIR=/var/solr/index1 sh start.sh
```

If you do not specific a port, your server will be running on the Solr default port 8983.  

[Solr Back Office - http://localhost:8983/solr](http://localhost:8983/solr)

*Stop*
```
sh stop.sh
```

