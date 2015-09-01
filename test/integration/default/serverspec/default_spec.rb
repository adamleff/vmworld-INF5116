require 'spec_helper'

describe 'vmworld::default' do
  it 'installed the correct version of nginx' do
    if os[:release].to_i == 6
      expect(package('nginx')).to be_installed.with_version('1.8.0-1.el6.ngx')
    elsif os[:release].to_i == 7
      expect(package('nginx')).to be_installed.with_version('1.8.0-1.el7.ngx')
    end
  end

  it 'wrote out a nginx config file' do
    expect(file('/etc/nginx/nginx.conf')).to be_readable
    expect(file('/etc/nginx/nginx.conf')).to be_owned_by('nginx')
    expect(file('/etc/nginx/nginx.conf')).to be_grouped_into('nginx')
  end

  it 'has a running nginx service that starts at startup' do
    expect(service('nginx')).to be_running
    expect(service('nginx')).to be_enabled
  end

  it 'is listening on port 8080' do
    expect(port(8080)).to be_listening
  end

  it 'returns my VMworld index page' do
    expect(command('curl http://localhost:8080').stdout).to match(/VMworld is big/)
  end
end
