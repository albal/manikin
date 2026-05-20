# -*- encoding: utf-8 -*-
# stub: puppetlabs_spec_helper 6.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "puppetlabs_spec_helper".freeze
  s.version = "6.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Puppet, Inc.".freeze, "Community Contributors".freeze]
  s.date = "2023-04-25"
  s.description = "Contains rake tasks and a standard spec_helper for running spec tests on puppet modules.".freeze
  s.email = ["modules-team@puppet.com".freeze]
  s.homepage = "http://github.com/puppetlabs/puppetlabs_spec_helper".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7".freeze)
  s.requirements = ["puppet, >= 7.0.0".freeze]
  s.rubygems_version = "3.4.20".freeze
  s.summary = "Standard tasks and configuration for module spec tests.".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<mocha>.freeze, ["~> 1.0"])
  s.add_runtime_dependency(%q<pathspec>.freeze, [">= 0.2", "< 2.0.0"])
  s.add_runtime_dependency(%q<puppet-lint>.freeze, [">= 3.0.0"])
  s.add_runtime_dependency(%q<puppet-syntax>.freeze, ["~> 3.0"])
  s.add_runtime_dependency(%q<rspec-github>.freeze, ["~> 2.0"])
  s.add_runtime_dependency(%q<rspec-puppet>.freeze, [">= 2.0"])
end
