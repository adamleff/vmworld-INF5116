case node['platform_version'].to_i
when 6
  default['nginx']['version'] = '1.8.0-1.el6.ngx'
when 7
  default['nginx']['version'] = '1.8.0-1.el7.ngx'
else
  default['nginx']['version'] = nil
end
