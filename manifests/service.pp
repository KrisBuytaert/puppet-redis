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
      /(?i)(RedHat|CentOS)/ => true,
		},
		require    => Class['redis::config']
	}
}
