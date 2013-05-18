class zookeeper::cleanup {

  $bin_dir    = $zookeeper::bin_dir
  $data_dir   = $zookeeper::data_dir
  $snap_dir   = $zookeeper::snap_dir
  $snap_count = $zookeeper::snap_count
  $user       = $zookeeper::user

  # also see https://github.com/wikimedia/puppet-cdh4/pull/11/files
  cron { 'zk-cleanup':
    command => "/usr/bin/java -cp zookeeper.jar:lib/slf4j-api-1.6.1.jar:lib/slf4j-log4j12-1.6.1.jar:lib/log4j-1.2.15.jar:conf org.apache.zookeeper.server.PurgeTxnLog $data_dir $snap_dir -n $snap_count",
    user    => $user,
    hour    => 2,
    minute  => fqdn_rand( 60 )
  }
}