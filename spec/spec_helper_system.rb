require 'rspec-system/spec_helper'
require 'rspec-system-foreman/helpers'

include RSpecSystemForeman::Helpers

RSpec.configure do |c|
  c.tty = true
  c.include RSpecSystemForeman::Helpers

  c.before :suite do
    unless ENV['FOREMAN_SKIP_INSTALL'] && ENV['FOREMAN_SKIP_INSTALL'] == '1'
      opts = {}
      opts[:repo] = ENV['FOREMAN_REPO'] if ENV['FOREMAN_REPO']
      opts[:custom_repo] = ENV['FOREMAN_CUSTOM_REPO'] if ENV['FOREMAN_CUSTOM_REPO']
      opts[:installer_source] = ENV['FOREMAN_INSTALLER_SOURCE'] if ENV['FOREMAN_INSTALLER_SOURCE']

      foreman_installer_install opts
      foreman_install
    end
  end
end
