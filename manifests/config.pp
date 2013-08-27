/*
 * Parameters:
 *   - heap_size: the size in MiB that you want to reserve on the heap for ZK.
 */
class zookeeper::config(
  $heap_size             = $zookeeper::params::heap_size,
  $java_opts             = $zookeeper::params::java_opts,
  $rollingfile_threshold = $zookeeper::params::rollingfile_threshold,
  $tracefile_threshold   = $zookeeper::params::tracefile_threshold,
) {
  $user            = $zookeeper::user
  $group           = $zookeeper::group
  $zoo_main        = 'org.apache.zookeeper.server.quorum.QuorumPeerMain'
  $log_dir         = $zookeeper::log_dir
  $data_dir        = $zookeeper::data_dir
  $etc_dir         = $zookeeper::etc_dir

  $myid            = $zookeeper::myid

  $java_bin        = '/usr/bin/java'
  $log4j_prop      = $zookeeper::log4j_prop
  $heap_opts       = "-Xms${heap_size}m -Xmx${heap_size}m"
  
  # zoo.cfg props:
  $servers         = $zookeeper::servers
  $client_port     = $zookeeper::client_port
  $manage_firewall = $zookeeper::manage_firewall

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

  file { $etc_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => 644,
  }

  file { "${data_dir}/myid":
    ensure  => file, 
    content => template("zookeeper/conf/myid.erb"), 
    owner   => $user,
    group   => $group,
    mode    => 644,
    require => File[$etc_dir],
  }

  file { "${etc_dir}/zoo.cfg":
    owner   => $user,
    group   => $group,
    mode    => 644,
    content => template("zookeeper/conf/zoo.cfg.erb"),
    require => File[$etc_dir], 
  }

  file { "${etc_dir}/environment":
    owner   => $user,
    group   => $group,
    mode    => 644,
    content => template("zookeeper/conf/environment.erb"),
    require => File[$etc_dir], 
  }

  file { "${etc_dir}/log4j.properties":
    owner   => $user,
    group   => $group,
    mode    => 644,
    content => template("zookeeper/conf/log4j.properties.erb"),
    require => File[$etc_dir], 
  }

  if $manage_firewall {
    firewall { "100 allow zookeeper:$client_port":
      proto   => 'tcp',
      state   => ['NEW'],
      dport   => $client_port,
      action  => 'accept',
    }
    firewall { "101 allow zookeeper:2888":
      proto   => 'tcp',
      state   => ['NEW'],
      dport   => 2888,
      action  => 'accept',
    }
    firewall { "102 allow zookeeper:3888":
      proto   => 'tcp',
      state   => ['NEW'],
      dport   => 3888,
      action  => 'accept',
    }
  }
}
