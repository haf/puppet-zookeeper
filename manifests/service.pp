class zookeeper::service(
  $ensure = 'running',
  $enable = true
) {
  $user      = $zookeeper::user
  $group     = $zookeeper::group
  $dir       = $zookeeper::zk_dir
  $log_dir   = $zookeeper::log_dir
  $data_dir  = $zookeeper::data_dir
  $etc_dir   = $zookeeper::etc_dir
  $bin_dir   = $zookeeper::bin_dir
  
  # TODO: verify
  # https://github.com/globocom/zookeeper-centos-6/blob/master/redhat/zookeeper.init

  svcutils::mixsvc { 'zookeeper':
    ensure      => $ensure,
    enable      => $enable,
    user        => $user,
    group       => $group,
    log_dir     => $log_dir,
    exec        => "${bin_dir}/zkServer.sh start",
    args        => '',
    description => 'ZooKeeper Server'
  } 
}