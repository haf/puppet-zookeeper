/*
 * Parameters:
 * 
 *   - servers: servers should be declared in the format
 *      of an array, with string items, like:
 *      ['zookeeper3:2888:3888', '...', ...]
 */
class zookeeper(
  $version  = $zookeeper::params::version,
  $myid     = $zookeeper::params::myid,
  $zk_dir   = $zookeeper::params::zk_dir,
  $log_dir  = $zookeeper::params::log_dir,
  $etc_dir  = $zookeeper::params::etc_dir,
  $data_dir = $zookeeper::params::data_dir,
  # consider: expose java bin?
  $client_port = $zookeeper::params::client_port,
  $snap_count  = $zookeeper::params::snap_count,
  $user        = $zookeeper::params::user,
  $group       = $zookeeper::params::group,
  $log4j_prop  = $zookeeper::params::log4j_prop,
  $servers     = $zookeeper::params::servers
) inherits zookeeper::params {
  include svcutils

  $bin_dir  = "$zk_dir/bin"
  $snap_dir = $data_dir

  # TODO: verify that svcutils cover all of https://github.com/globocom/zookeeper-centos-6/blob/master/redhat/zookeeper.init

  if ! defined(Class['java']) {
    class { 'java':
      distribution => 'jre',
    }
  }

  anchor { 'zookeeper::start': }

  class { 'zookeeper::package':
    require => [
      Anchor['zookeeper::start'], 
      Class['java']
    ],
    before  => Anchor['zookeeper::end'],
  } ->

  class { 'zookeeper::cleanup':
    require => Anchor['zookeeper::start'],
    before  => Anchor['zookeeper::end'],
  } ->

  class { 'zookeeper::config': 
    require => Anchor['zookeeper::start'],
    before  => Anchor['zookeeper::end'],
  } ~>

  class { "zookeeper::service":
    ensure  => "running",
    enable  => true,
    require => [ 
      Anchor['zookeeper::start'],
      Class['zookeeper::config']
    ],
    before  => Anchor['zookeeper::end'],
   }

  anchor { 'zookeeper::end': }
}

# inspiration:
# https://github.com/wikimedia/puppet-cdh4
# https://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_provisioning
# http://apache.mirror3.ip-only.net/zookeeper/
# https://github.com/globocom/zookeeper-centos-6/blob/master/redhat/zookeeper.init
# https://github.com/garethr/garethr-zookeeper/tree/master/manifests

