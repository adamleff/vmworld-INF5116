#
# Cookbook Name:: vmworld
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'nginx' do
  version node['nginx']['version']
  action :install
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  user 'nginx'
  group 'nginx'
  mode '0644'
  action :create
  notifies :restart, 'service[nginx]', :immediately
end

directory '/website' do
  user 'nginx'
  group 'nginx'
  mode '0755'
  action :create
end

template '/website/index.html' do
  source 'index.html.erb'
  user 'nginx'
  group 'nginx'
  mode '0644'
  action :create
end

service 'nginx' do
  action [ :enable, :start ]
end
