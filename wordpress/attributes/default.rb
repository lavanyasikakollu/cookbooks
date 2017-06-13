
case node['platform_family']
when 'rhel'
  default['wordpress']['webserver'] = 'httpd'
  default['wordpress']['config_loc'] = '/etc/httpd/conf.d/httpd.conf'
  default['wordpress']['service_name'] = 'httpd'
  default['wordpress']['mysql_conf'] = '/etc/my.cnf'
  default['wordpress']['mysql_service'] = 'mariadb'
when 'debain'
  default['wordpress']['webserver'] = 'apache2'
  default['wordpress']['config_loc'] = '/etc/httpd/conf.d/'
  default['wordpress']['service_name'] = 'apache2'
end

