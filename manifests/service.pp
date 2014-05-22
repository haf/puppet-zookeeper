class zookeeper::service(
  $ensure = 'running',
  $enabled = true
) {
  $user       = $zookeeper::user
  $group      = $zookeeper::group
  $dir        = $zookeeper::zk_dir
  $log_dir    = $zookeeper::log_dir
  $data_dir   = $zookeeper::data_dir
  $etc_dir    = $zookeeper::etc_dir
  $bin_dir    = $zookeeper::bin_dir
  $log4j_prop = $zookeeper::log4j_prop

  $classpath = globby_join("${bin_dir}/{../lib,..}/*.jar", ':')
  $log_conf = 'file:///etc/zookeeper/log4j.properties'


  service { 'zookeeper':
    ensure => $ensure,
    enable => $enabled,
  }

}

# \"-Dzookeeper.log.dir=${ZOO_LOG_DIR}\" \"-Dzookeeper.root.logger=${ZOO_LOG4J_PROP}\" -cp ${CLASSPATH} ${ZOOMAIN} ${ZOOCFG}
