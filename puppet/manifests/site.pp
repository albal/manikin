node 'dev.puppetlabs.vm' {
  # Configure webserver
  include webserver
  include jenkins
}
