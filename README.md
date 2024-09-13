# HBase Docker Image

Version is configured as a build argument, default at the time of writing is
`2.6.0`. Possibly `hbase-site.xml` needs to be updated, that may be done by
building an image on top of this one.

```Dockerfile
FROM this-image

COPY hbase-site.xml $HBASE_HOME/conf/
```
