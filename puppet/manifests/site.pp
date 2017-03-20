node 'dev.puppetlabs.vm' {
  # Configure mysql
  class { 'mysql::server':  root_password => '8ZcJZFHsvo7fINZcAvi0' }

  # Configure apache
  class { 'apache': default_vhost => false }
  include apache::mod::php
  apache::vhost { $::fqdn:
    port    => '80',
    docroot => '/var/www/test',
    require => File['/var/www/test'],
  }

  # Configure Docroot and index.html
  file { ['/var/www', '/var/www/test']:
    ensure => directory
  }

  file { '/var/www/test/index.php':
    ensure  => file,
    content => '<?php echo \'<p>Hello World</p>\'; ?> ',
  }
}
