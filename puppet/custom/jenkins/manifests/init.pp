# Class: jenkins
# ===========================
#
# Full description of class jenkins here.
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
#    class { 'jenkins':
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
class jenkins {
  include java

  yumrepo {'jenkins':
    baseurl  =>  'http://pkg.jenkins.io/redhat-stable',
    descr    =>  'Jenkins repository',
    enabled  =>  1,
    gpgcheck =>  1,
    require  => Remote_file['/etc/pki/rpm-gpg/RPM-GPG-KEY-jenkins'],
  }

  remote_file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-jenkins':
    ensure => present,
    source => 'https://pkg.jenkins.io/redhat-stable/jenkins.io.key',
  }

  exec { 'validate gpg key':
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => 'gpg --keyid-format 0xLONG /etc/pki/rpm-gpg/RPM-GPG-KEY-jenkins | grep -q 947A3F44C2734255',
    require   => Remote_file['/etc/pki/rpm-gpg/RPM-GPG-KEY-jenkins'],
    logoutput => 'on_failure',
  }

  exec { 'import gpg key':
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => 'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-jenkins',
    unless    => 'rpm -q gpg-pubkey-`echo $(gpg --throw-keyids < /etc/pki/rpm-gpg/RPM-GPG-KEY-jenkins:w) | cut --characters=11-18 | tr [A-Z] [a-z]`',
    require   => [ Remote_file['/etc/pki/rpm-gpg/RPM-GPG-KEY-jenkins'], Exec['validate gpg key'] ],
    logoutput => 'on_failure',
  }

  package { 'jenkins':
    ensure  => installed,
    require => Yumrepo['jenkins'],
  }

  service {'jenkins':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  java::oracle { 'jdk8' :
    ensure  => 'present',
    version => '8',
    java_se => 'jdk',
    before  => Service['jenkins'],
  }

}
