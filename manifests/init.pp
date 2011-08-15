# Class: redis
#
#
class redis {
  require redis::params
  
  include redis::install, redis::config, redis::service
}
