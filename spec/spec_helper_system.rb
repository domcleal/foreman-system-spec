require 'rspec-system/spec_helper'
require 'rspec-system-foreman/helpers'

include RSpecSystemForeman::Helpers

RSpec.configure do |c|
  c.tty = true
  c.include RSpecSystemForeman::Helpers

  c.before :suite do
    unless ENV['FOREMAN_SKIP_INSTALL'] && ENV['FOREMAN_SKIP_INSTALL'] == '1'
      installer = {}
      answers = {:foreman => {}, :foreman_proxy => {}}

      if ENV['FOREMAN_REPO']
        installer[:repo] = ENV['FOREMAN_REPO']
        answers[:foreman][:repo] = ENV['FOREMAN_REPO']
        answers[:foreman_proxy][:repo] = ENV['FOREMAN_REPO']
      end

      if ENV['FOREMAN_CUSTOM_REPO']
        installer[:custom_repo] = ENV['FOREMAN_CUSTOM_REPO']
        answers[:foreman][:custom_repo] = true
        answers[:foreman_proxy][:custom_repo] = true
      end

      installer[:installer_source] = ENV['FOREMAN_INSTALLER_SOURCE'] if ENV['FOREMAN_INSTALLER_SOURCE']

      foreman_installer_install installer
      foreman_install :answers => answers
    end
  end
end
