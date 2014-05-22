class zookeeper::package inherits zookeeper::params {
  $version      = $zookeeper::version
  $download_url = "${zookeeper::params::download_url_base}/zookeeper-$version/zookeeper-$version.tar.gz"
  $zk_dir       = $zookeeper::zk_dir
  $user         = $zookeeper::user
  $group        = $zookeeper::group



  # spec file for zookeeper rpm can be found at https://github.com/skottler/zookeeper-rpms
  # currently 20140521   nc is a missing dependency in the specfile


  package { 'zookeeper':
    ensure => $version,
  }

  package {'nc':
    ensure => present,
  }



}
