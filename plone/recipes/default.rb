#
# Cookbook Name:: plone
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package ['gcc-c++', 'patch', 'openssl-devel', 'libjpeg-devel', 'libxslt-devel', 'make', 'which', 'python-devel'] do
  action :install
end

package 'git' do
  action :install
end

remote_file '/tmp/Plone-5.0.4-UnifiedInstaller.tgz' do
  source 'https://launchpad.net/plone/5.0/5.0.4/+download/Plone-5.0.4-UnifiedInstaller.tgz'
  owner 'root'
  group 'root'
  not_if { ::File.exist?("/tmp/Plone-5.0.4-UnifiedInstaller.tgz") }
end

execute 'extracting the plone package' do
  cwd '/tmp'
  command 'tar -xf Plone-5.0.4-UnifiedInstaller.tgz /var/www/html/;chown -R root.root /var/www/html/Plone-5.0.4-UnifiedInstaller'
  action :run
  not_if { ::File.exist?("/var/www/html/Plone-5.0.4-UnifiedInstaller/") }
end

directory '/opt/Plone' do
  owner 'root'
  group 'root'
  mode 755
  recursive true
  action :create
  not_if { ::File.exist?("/opt/Plone")}
end

execute 'running the plone installation script' do
  cwd '/var/www/html/Plone-5.0.4-UnifiedInstaller/'
  command './install.sh Standalone --target="/opt/Plone/" --password="admin"'
  action :run
end
template '/opt/Plone/zinstance/develop.cfg' do
	source "develop.cfg.erb"
end
execute 'Install the Plone developer tools' do
  cwd '/opt/Plone/zinstance'
  command 'bin/buildout -c develop.cfg'
  action :run
end

execute 'Start Plone' do
  cwd '/opt/Plone/zinstance'
  command 'bin/plonectl start'
  action :run
end

