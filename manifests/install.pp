# Class: redis::install
#
#
class redis::install {
  include buildenv::c

  common::archive { "redis-${redis::params::version}":
    ensure   => present,
    checksum => false,
    url      => "http://redis.googlecode.com/files/redis-${redis::params::version}.tar.gz",
    timeout  => 600,
    target   => '/usr/src',
    notify   => Exec['make-redis'],
  }

  exec { 'make-redis':
    command     => '/usr/bin/make',
    cwd         => "/usr/src/redis-${redis::params::version}",
    creates     => "/usr/src/redis-${redis::params::version}/redis",
    refreshonly => true,
    notify      => Exec['make-install-redis'],
    require     => Common::Archive["redis-${redis::params::version}"],
  }

  exec { 'make-install-redis':
    command     => '/usr/bin/make install',
    cwd         => "/usr/src/redis-${redis::params::version}",
    creates     => '/usr/local/bin/redis-server',
    refreshonly => true,
    require     => Exec['make-redis'],
  }

  user::managed { $redis::params::user:
    uid          => 202,
    gid          => uid,
    shell        => '/bin/false',
    name_comment => 'Redis system account',
    homedir      => "/home/${redis::params::user}",
    managehome   => false,
    password     => '!'
  }
}
