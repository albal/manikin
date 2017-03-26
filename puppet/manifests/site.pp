node 'dev.puppetlabs.vm' {
  # Configure mysql
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
    content => '<?php info() ?>',
  }

}
