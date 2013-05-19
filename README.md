#puppet-zookeeper

This is a module written from scratch, but based on some other puppet modules for ZK found around.

Reason being:

 - I want something that works on CentOS
 - Others had bugs in them
 - Others didn't manage users and groups
 - Others assumed I would package zookeeper by the side

A puppet receipt for [Apache Zookeeper](http://zookeeper.apache.org/). ZooKeeper is a high-performance coordination service for maintaining configuration information, naming, providing distributed synchronization, and providing group services.

## Basic Usage:

    class { 'zookeeper': }
    
##  Parameters

   - `myid` - cluster-unique zookeeper's instance id (1-255)

