# Class: redis::package
#
#
class redis::package {

  package { 'redis':
    #  ensure => '2.4.10-1.el6',
    ensure => 'present',
  }

}

