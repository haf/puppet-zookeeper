class zookeeper::params {
  $version           = '3.4.5'
  $download_url_base = 'http://apache.mirror3.ip-only.net/zookeeper'
  
  
  $myid        = hiera('myid', '1')
  
  # directories
  $zk_dir      = '/opt/zookeeper'
  $log_dir     = '/var/log/zookeeper'
  $etc_dir     = '/etc/zookeeper'
  $data_dir    = '/var/lib/zookeeper'

  # knowns
  $java_bin    = '/usr/bin/java'
  $java_opts   = ''
  
  $client_port = 2181
  $snap_count  = 10000
  $user        = 'zookeeper'
  $group       = 'zookeeper'

  # what servers are in the cluster
  $servers     = ['']

  # log4j properties
  $heap_size             = 1000
  $log4j_prop            = 'INFO,ROLLINGFILE'
  $rollingfile_threshold = 'ERROR'
  $tracefile_threshold   = 'TRACE'
}