# Class: redis::service
#
#
class redis::service {
  service { 'redis-server':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => $operatingsystem ? {
      /(?i)(Debian|Ubuntu)/ => false,
      /(?i)(RedHat|CentOS)/ => false,
    },
    pattern    => 'redis-server',
    require    => Class['redis::config']
  }
}
