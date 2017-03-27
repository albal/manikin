# Class: webserver
# ===========================
#
# Full description of class webserver here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'webserver':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class webserver {

  # configure mysql
  class { 'mysql::server':
    root_password => '8ZcJZFHsvo7fINZcAvi0'
  }

  # Configure apache
  class { 'apache':
    default_vhost => false
  }

  include apache::mod::php

  apache::vhost { $::fqdn:
    port    => '80',
    docroot => '/var/www/test',
    require => File['/var/www/test'],
  }

  apache::vhost{ 'php':
    port    => '80',
    docroot => '/var/www/php',
    require => File['/var/www/php']
  }

  # Configure Docroot and index.html
  file { '/var/www':
    ensure => directory
  }

  file { '/var/www/test':
    ensure  => directory,
    require => File['/var/www'],
  }

  file { '/var/www/php':
    ensure  => directory,
    require => File['/var/www'],
  }

  file { '/var/www/test/index.php':
    ensure  => file,
    content => '<?php echo \'<p>Hello World</p>\'; ?>',
  }

  file { '/var/www/php/index.php':
    ensure  => file,
    content => '<?php phpinfo() ?>',

  }

}
