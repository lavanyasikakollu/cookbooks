
case node['platform_family']
when 'rhel'
  default['wordpress1']['webserver'] = 'httpd'
  default['wordpress1']['config_loc'] = '/etc/httpd/conf.d/httpd.conf'
  default['wordpress1']['service_name'] = 'httpd'
  default['wordpress1']['mysql_conf'] = '/etc/my.cnf'
  default['wordpress1']['mysql_service'] = 'mariadb'
when 'debain'
  default['wordpress1']['webserver'] = 'apache2'
  default['wordpress1']['config_loc'] = '/etc/httpd/conf.d/'
  default['wordpress1']['service_name'] = 'apache2'
end

