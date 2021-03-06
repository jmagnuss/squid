require 'spec_helper'

describe 'squid::default on Ubuntu 16.04' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do
    end.converge('squid::default')
  end

  it 'installs package squid3' do
    expect(chef_run).to install_package('squid3')
  end

  it 'templates /etc/squid3/squid.conf' do
    expect(chef_run).to create_template('/etc/squid3/squid.conf')
  end
end

describe 'squid::default on CentOS 6' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do
    end.converge('squid::default')
  end

  it 'installs package squid' do
    expect(chef_run).to install_package('squid')
  end

  it 'templates /etc/sysconfig/squid' do
    expect(chef_run).to create_template('/etc/sysconfig/squid')
  end

  it 'templates /etc/squid/squid.conf' do
    expect(chef_run).to create_template('/etc/squid/squid.conf')
  end
end

describe 'squid::default on FreeBSD 10' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'freebsd', version: '10.3') do
    end.converge('squid::default')
  end

  it 'creates missing directories' do
    expect(chef_run).to run_execute('squid -Nz').with(
      creates: '/var/squid/cache/00'
    )
  end

  it 'installs package squid' do
    expect(chef_run).to install_package('squid')
  end

  it 'creates /usr/local/etc/squid' do
    expect(chef_run).to create_directory('/usr/local/etc/squid')
  end

  it 'templates /usr/local/etc/squid/squid.conf' do
    expect(chef_run).to create_template('/usr/local/etc/squid/squid.conf')
  end
end
