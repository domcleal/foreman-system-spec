require 'spec_helper_system'
require 'json'

describe "Foreman's ENC smart proxy auth" do
  before :all do
    # reset the test
    ids = []
    foreman_cli :c => '--smart_proxies' do |r|
      ids = r.output.map { |p| p['smart_proxy']['id'] }
    end
    log.info "Deleting #{ids.size} already-registered smart proxies"
    ids.each do |p|
      shell "curl --cacert /var/lib/puppet/ssl/certs/ca.pem -u admin:changeme -X DELETE https://#{node}/api/smart_proxies/#{p}"
    end
  end

  it 'should fail to run Puppet agent' do
    puppet_agent do |r|
      r.exit_code == 1
    end
  end

  it 'should successfully add a smart proxy' do
    shell "curl --cacert /var/lib/puppet/ssl/certs/ca.pem -u admin:changeme -d 'smart_proxy[name]=#{node}&smart_proxy[url]=https://#{node}:8443' https://#{node}/api/smart_proxies" do |r|
      r.exit_code.should == 0
      j = JSON.parse(r.stdout)
      j['smart_proxy'].should_not be_nil
      j['smart_proxy']['id'].should_not be_nil
    end
  end

  it 'should run Puppet agent successfully' do
    puppet_agent do |r|
      r.exit_code.should == 0
    end
  end

  it 'should list itself in the hosts output' do
    foreman_cli :c => '--hosts' do |r|
      r.output.should_not == []
      r.output.size.should == 1
      r.output[0]['host']['name'].should == node.to_s
    end
  end
end
