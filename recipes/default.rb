# ensure jenkins only listens on localhost
node.set[:jenkins][:server][:host] = '127.0.0.1'

# this sets up a non-ssl vhost in the jenkins cookbook as well as some
# additional bits such as htpasswd file. We will optionally disable
# non-ssl vhost later.
node.set[:jenkins][:http_proxy][:variant] = 'apache2'

include_recipe "apache2"
include_recipe "apache2::mod_ssl"
include_recipe "jenkins"

host_name = node[:jenkins][:http_proxy][:host_name] || node[:fqdn]

template "#{node[:apache][:dir]}/sites-available/jenkins_ssl" do
  source      "apache_jenkins_ssl.erb"
  owner       'root'
  group       'root'
  mode        '0644'
  variables(
    :host_name        => host_name,
    :host_aliases     => node[:jenkins][:http_proxy][:host_aliases],
    :listen_ports     => node[:jenkins][:http_proxy][:listen_ports],
    :ssl_key_file     => node[:sensu_jenkins][:ssl_key_file],
    :ssl_cert_file    => node[:sensu_jenkins][:ssl_cert_file],
    :ssl_ca_file      => node[:sensu_jenkins][:ssl_ca_file]
  )

  if File.exists?("#{node[:apache][:dir]}/sites-enabled/jenkins_ssl")
    notifies  :restart, 'service[apache2]'
  end
end

if node[:sensu_jenkins][:disable_non_ssl] == true
  apache_site "jenkins" do
    enable false
  end
end

apache_site "jenkins_ssl" do
  enable true
end
