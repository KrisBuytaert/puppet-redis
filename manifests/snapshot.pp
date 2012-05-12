# Define: snapshot
# Parameters:
# $hour = undef, $minute = undef
#
# This resource installs a cron job that issues the SAVE command to redis so as to make it
# dump its data on disk in $redis::params::libdir
define snapshot ($hour     = undef,
$minute   = undef,
$month    = undef,
$monthday = undef,
$weekday  = undef) {
  cron { "redis-snapshot-${name}":
    command  => '/usr/local/bin/redis-cli SAVE',
    user     => $redis::params::user,
    hour     => $hour,
    minute   => $minute,
    month    => $month,
    monthday => $monthday,
    weekday  => $weekday,
  }
}
