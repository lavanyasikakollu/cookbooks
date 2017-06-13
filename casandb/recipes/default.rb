#
# Cookbook Name:: casandb
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'java-1.8.0'


cookbook_file '/etc/yum.repos.d/datastax.repo' do
source "datst.repo"
end

package 'dsc30' do
action :install
end

package 'cassandra30-tools' do
action :install
end

service 'cassandra' do 
action [ :enable, :start ]
end

