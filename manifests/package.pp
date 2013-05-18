class zookeeper::package inherits zookeeper::params {
  $version      = $zookeeper::version
  $download_url = "${zookeeper::params::download_url_base}/zookeeper-$version/zookeeper-$version.tar.gz"
  $zk_dir       = $zookeeper::zk_dir

  class { 'wget': }

  wget::fetch { 'download_zookeeper':
    source      => $download_url,
    destination => "/usr/local/src/zookeeper-$version.tar.bz",
    before      => Exec['untar_zookeeper'],
  }

  exec { 'untar_zookeeper':
    command => 'tar xvfj /usr/local/src/zookeeper-$version.tar.bz',
    cwd     => '/opt',
    creates => '${zk_dir}-$version',
    path    => ['/bin', '/usr/bin'],
    before  => File[$zk_dir]
  }

  file { $zk_dir:
    ensure => link,
    target => "${zk_dir}-$version"
  }
}
