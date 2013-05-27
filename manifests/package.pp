class zookeeper::package inherits zookeeper::params {
  $version      = $zookeeper::version
  $download_url = "${zookeeper::params::download_url_base}/zookeeper-$version/zookeeper-$version.tar.gz"
  $zk_dir       = $zookeeper::zk_dir
  $user         = $zookeeper::user
  $group        = $zookeeper::group
  
  
#  notify { $zk_dir:
#    message => "### $zk_dir"
#  }

  wget::fetch { 'download_zookeeper':
    source      => $download_url,
    destination => "/usr/local/src/zookeeper-$version.tar.bz",
    before      => Exec['untar_zookeeper'],
    require     => Class['wget'],
  }

  exec { 'untar_zookeeper':
    command => "tar xzvf /usr/local/src/zookeeper-$version.tar.bz",
    cwd     => '/opt',
    creates => "${zk_dir}-$version",
    path    => ['/bin', '/usr/bin'],
    before  => File[$zk_dir],
  }

  file { $zk_dir:
    ensure => link,
    target => "${zk_dir}-$version"
  }

  file { "${zk_dir}-$version":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    recurse => true,
    require => Exec['untar_zookeeper'],
  }
}
