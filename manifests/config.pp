/*
 * Parameters:
 *   - heap_size: the size in MiB that you want to reserve on the heap for ZK.
 */
class zookeeper::config(
  $heap_size             = $zookeeper::params::heap_size,
  $java_opts             = $zookeeper::params::java_opts,
  $log4j_prop            = $zookeeper::params::log4j_prop,
  $rollingfile_threshold = $zookeeper::params::rollingfile_threshold,
  $tracefile_threshold   = $zookeeper::params::tracefile_threshold,
  # zoo.cfg props:
  # ...
) inherits zookeeper::params {
  $user        = $zookeeper::user
  $group       = $zookeeper::group
  $zoo_main    = 'org.apache.zookeeper.server.quorum.QuorumPeerMain'
  $log_dir     = $zookeeper::log_dir
  $data_dir    = $zookeeper::data_dir
  $cfg_dir     = $zookeeper::cfg_dir

  $myid        = $zookeeper::myid

  $java_bin    = '/usr/bin/java'
  $log4j_prop  = $zookeeper::log4j_prop
  $heap_opts   = "-Xms${heap_size}m -Xmx${heap_size}m"
  
  # zoo.cfg props:
  $servers     = $zookeeper::servers
  $client_port = $zookeeper::client_port

  file { "${log_dir}":
    owner  => $user,
    group  => $group,
    mode   => 644,
    ensure => directory,
  }

  file { "${data_dir}":
    ensure => directory, 
    owner  => $user,
    group  => $group,
    mode   => 644, 
  }

  file { "${cfg_dir}/myid":
    ensure  => file, 
    content => template("zookeeper/conf/myid.erb"), 
    owner   => $user,
    group   => $group,
    mode    => 644, 
  }

  file { "${cfg_dir}/zoo.cfg":
    owner   => $user,
    group   => $group,
    mode    => 644,
    content => template("zookeeper/conf/zoo.cfg.erb"), 
  }

  file { "${cfg_dir}/environment":
    owner   => $user,
    group   => $group,
    mode    => 644,
    content => template("zookeeper/conf/environment.erb"), 
  }

  file { "${cfg_dir}/log4j.properties":
    owner   => $user,
    group   => $group,
    mode    => 644,
    content => template("zookeeper/conf/log4j.properties.erb"), 
  }
}
