# Class: redis::config
#
#
class redis::config {
  file { $redis::params::libdir:
		ensure  => directory,
		owner   => $redis::params::user,
		group   => $redis::params::user,
		require => Class['redis::install'],
	}	
	
	file { $redis::params::logdir:
		ensure  => directory,
		owner   => $redis::params::user,
		group   => $redis::params::user,
		require => Class['redis::install'],
	}
	
	file { '/etc/init.d/redis-server':
		content => template("redis/redis.init.${redis::params::os_suffix}.erb"),
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		require => Class['redis::install'],
	}
	
	file { $redis::params::configfile:
		content => template('redis/redis.conf.erb'),
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		require => Class['redis::install'],
	}
	
	logrotate::file { 'redis-logfile': 
    log     => "${redis::params::logdir}/redis.log",
    options => [ 'daily', 'dateext', 'missingok', 'rotate 5', 'compress', 'copytruncate' ],
  }
}
