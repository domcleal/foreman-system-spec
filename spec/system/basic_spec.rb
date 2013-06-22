require 'spec_helper_system'
require 'net/http'
require 'json'

describe 'after foreman-installer' do
  it 'should report an OK status' do
    foreman_cli :c => '--status' do |r|
      r.output['result'].should == 'ok'
      r.output['status'].should == 200
    end
  end

  it 'should redirect on port 80' do
    shell "curl http://#{node}/" do |r|
      r.exit_code.should == 0
      r.stdout.should include("https://#{node}")
      r.stdout.should include("redirected")
    end
  end

  it 'should redirect to login page on HTTPS' do
    shell "curl --cacert /var/lib/puppet/ssl/certs/ca.pem https://#{node}/" do |r|
      r.exit_code.should == 0
      r.stdout.should include("https://#{node}/users/login")
      r.stdout.should include("redirected")
    end
  end
end
