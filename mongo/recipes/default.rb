#
# Cookbook Name:: mongo
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file '/etc/yum.repos.d/mongodb-org-3.4.repo' do
source "mongo.repo"
 end

package 'mongodb-org' do
action :install
end

service 'mongod' do
action [ :enable, :start ]
end
