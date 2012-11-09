#
# Cookbook Name:: zend
# Recipe:: default
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['zend']['install']
  when "zend-cluster-manager"
    node[:zend][:application] = "zend-server-cluster-manager"
  else
    case node['zend']['install']
      when "zend-server"
        node[:zend][:application] = "zend-server-php-#{node[:zend][:php][:version]}"
      else
        node[:zend][:application] = "zend-server-ce-php-#{node[:zend][:php][:version]}"
    end
end

case node['platform']
  when "centos", "redhat", "fedora", "scientific", "amazon"
    execute "create-yum-cache" do
      command "yum -q makecache"
      action :nothing
    end
    ruby_block "reload-yum-cache" do
      block do
        Chef::Provider::Package::Yum::YumCache.instance.reload
      end
      action :nothing
    end
    template "/etc/yum.repos.d/zend.repo" do
      source "zend.rpm.repo.erb"
      mode "0644"
      notifies :run, resources(:execute => "create-yum-cache"), :immediately
      notifies :create, resources(:ruby_block => "reload-yum-cache"), :immediately
    end

  when "debian", "ubuntu"
    execute "zend-apt-gpg-key" do
      command "wget http://repos.zend.com/zend.key -O- | apt-key add -"
      action :run
    end
    cookbook_file "/etc/apt/sources.list.d/zend.list" do
      source "zend.deb.repo"
      mode "0644"
    end
    execute "apt-get update"

end

package "#{node[:zend][:application]}" do
  action [:install, :upgrade]
end

package "cli-tools-zend-server" do
  action [:install, :upgrade]
end

unless node[:zend][:application] == "zend-server-cluster-manager"
  node[:zend][:packages].each do |name, actions|
    unless actions.to_s == 'nothing'
      package "php-#{node[:zend][:php][:version]}-#{name}-zend-server" do
        action actions
      end
    end
  end
end

cookbook_file "/etc/profile.d/zend.sh" do
  source "profile.sh"
end

template "/etc/logrotate.d/zend" do
  source "logrotate.erb"
  variables(
      :size => node[:zend][:log_rotate][:size],
      :rotate => node[:zend][:log_rotate][:rotate]
  )
end

directory "/var/log/apache2/" do
  mode "0755"
end


unless node[:zend][:accept_eula].nil?
  zend_eula "accept-eula"
end

unless node[:zend][:order_id].nil?
  zend_license "#{node[:zend][:order_id]}" do
    license_key "#{node[:zend][:license_key]}"
  end
end

unless node[:zend][:gui_passwd].nil?
  zend_password "#{node[:zend][:gui_passwd]}"
end

service "zend" do
  service_name "zend-server"
  supports :status => true, :restart => true
  action [:enable, :start, :restart]
end
