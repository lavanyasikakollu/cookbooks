#
# Cookbook Name:: wordpress1
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package node['wordpress1']['webserver'] do
  action :install
end


package 'mariadb-server' do
  action :install
end

service node['wordpress1']['mysql_service'] do
  supports :status => true
  action [ :enable, :start ]
end

execute 'Changing the mysql root password' do
command <<-EOF
mysqladmin -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'password';"
mysqladmin -e "FLUSH PRIVILEGES;"
mysqladmin -e "create database wordpress;"
mysqladmin -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';"
EOF
end

#command 'mysqladmin -uroot password Welcome123'
 #action :run
#end

package ['php', 'php-mysql', 'php-gd', 'php-ldap', 'php-odbc', 'php-pear'] do
  action :install
end

remote_file '/tmp/latest.tar.gz' do
  source 'http://wordpress.org/latest.tar.gz'
  owner 'root'
  group 'root'
  not_if { ::File.exist?('/tmp/latest.tar.gz') }
end
execute 'extracting the wordpress zip file' do
  cwd '/tmp'
  command 'tar -xvzf latest.tar.gz -C /var/www/html/;chown -R root.root /var/www/html/wordpress'
  action :run
end

service node['wordpress1']['service_name'] do
  supports :status => true, :start => true, :restart => true, :stop => true
  action [ :enable, :start ]
end

