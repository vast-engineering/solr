solr
====

Production-ready maven project for Solr projects.

Configure
=========
You can setup solr configurations here:

[Click here to see the Solr configuration folder](https://github.com/vast-eng/solr/tree/master/src/main/config)


Install 
=======
Currently, the embedded Jetty server is only available internally to Vast.  For now, you need to setup internal Vast maven repo.  Sorry to public folks, I will try to get this fixed.

```
mvn install

```

Start Server
============
Navigate to the target/your-index-0.0.0-SNAPSHOT directory, then use the start/stop scripts.

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