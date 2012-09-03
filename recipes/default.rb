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

case node['platform']
  when "centos", "redhat", "fedora", "scientific", "amazon"
    execute "create-yum-cache" do
      command "yum -q makecache"
      action :nothing
    end

    ruby_block "reload-internal-yum-cache" do
      block do
        Chef::Provider::Package::Yum::YumCache.instance.reload
      end
      action :nothing
    end

    template "/etc/yum.repos.d/zend.repo" do
      source "zend.rpm.repo.erb"
      mode "0644"
      notifies :run, resources(:execute => "create-yum-cache"), :immediately
      notifies :create, resources(:ruby_block => "reload-internal-yum-cache"), :immediately
    end

    package "zend-server-php-#{node[:zend][:php][:version]}" do
      action :install
      provider Chef::Provider::Package::Yum
    end
##
  when "debian", "ubuntu"

    execute "zend-apt-gpg-key" do
      command "wget http://repos.zend.com/zend.key -O- | apt-key add -"
      action :run
    end

    execute "update-apt-cache" do
      command "apt-get -q -y update"
      action :nothing
    end

    template "/etc/apt/sources.list.d/zend.list" do
      source "zend.deb.repo.erb"
      mode "0644"
      notifies :run, resources(:execute => "update-apt-cache"), :immediately
    end

    apt_package "zend-server-php-#{node[:zend][:php][:version]}" do
      action :install
    end
##
  when "suse"

    execute "install_zend-server" do
      command "zypper --no-cd -q -n install -l zend-server-php-#{node[:zend][:php][:version]}"
      action :nothing
    end

    execute "update-zypper-cache" do
      command <<-EOF
      rpm --import http://repos.zend.com/zend.key
      zypper service-add http://repos.zend.com/zend-server/sles/ZendServer-#{node['kernel']['machine']} "ZendServer-#{node['kernel']['machine']}"
      zypper service-add http://repos.zend.com/zend-server/sles/ZendServer-noarch "ZendServer-noarch"
      zypper update
      EOF
      action :run
      notifies :run, resources(:execute => "install_zend-server"), :immediately
    end

##
end

service "zend" do
  service_name "zend-server"
  supports :status => true, :restart => true
  action [:enable, :start]
end

zend_command = "#{node[:zend][:zs_prefix]}/bin/zs-setup"

if !node[:zend][:server][:accept_eula].nil?
  execute "#{zend_command} accept-eula"
end

if !node[:zend][:server][:gui_passwd].nil?
  execute "#{zend_command} set-password #{node[:zend][:server][:gui_passwd]}"
end

if !node[:zend][:server][:order_id].nil? and !node[:zend][:server][:server_license_key].nil?
  execute "#{zend_command} set-license #{node[:zend][:server][:order_id]} #{node[:zend][:server][:server_license_key]}"
end

