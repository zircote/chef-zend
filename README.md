Description
===========

Installs and configures
 - [Zend Server Community Edition](http://www.zend.com/en/products/server-ce/)
 - [Zend Server](http://www.zend.com/en/products/server/)
 - [Zend Server Cluster Manager](http://www.zend.com/en/products/server/multi-server-support)

Requirements
============

#### `zend` cookbook

Tested on
 - Ubuntu 12.04LTS x86_64
 - Centos 6.3 x86_64


Attributes
==========

```ruby
# zend-server: Zend Server
# zend-ce: Zend Server Community Edition
# zend-cluster-manager: Zend Server Cluster Manager
default[:zend][:install] = "zend-server" # zs|ce|zcm
# 5.2|5.3
default[:zend][:php][:version] = "5.3"
```

### Zend Server Settings

Cluster manager settings, license, order id, password and eula acceptance.

```ruby
# Cluster Manager Membership Provisioning.
default[:zend][:cluster_manager][:add_server] = false
# name to give new server (required)
default[:zend][:cluster_manager][:name] = nil
# new server's GUI password (required)
default[:zend][:cluster_manager][:password] = nil
# Web API key name (required)
default[:zend][:cluster_manager][:key_name] = nil
# Web API secret key (required)
default[:zend][:cluster_manager][:secret_key] = nil
# https://zcm_host:10082/ZendServerManager
# http://zcm_host:10081/ZendServerManager
# new server's full ZS GUI URL (required)
default[:zend][:cluster_manager][:url] = "http://localhost:10081/ZendServerManager"
# do not restart PHP after adding this server (PHP is restarted by default)
default[:zend][:cluster_manager][:restart] = true
# propagate the new server's settings to the entire cluster
default[:zend][:cluster_manager][:propagate] = true
# retry action <value> times if server is locked; default is 3
default[:zend][:cluster_manager][:server_retry] = 3
# wait <value> seconds between retires; default is 5
default[:zend][:cluster_manager][:wait] = 5

```

### Optional package selections

```ruby
# To install the package(s)
default[:zend][:packages]['ssh2'] = [:install]
# To remove the package(s)
default[:zend][:packages]['ssh2'] = [:remove]
# to install and/or upgrade the package(s)
default[:zend][:packages]['ssh2'] = [:install, :upgrade]
```

## Resources

`zend_cluster`

```ruby
zend_cluster "my-zend-server-name" do
  zs_url "http://localhost:10081/ZendServer" # optional
  password "vagrant"
  server_retry 10 # optional
  wait 5 # optional
  restart false # optional
  propagate false # optional
  zcm_url "http://zcm.localhost.local:10081/ZendServerManager"
  key_name "zircote-api-key"
  secret_key node[:zend][:cluster_manager][:secret_key]
end
```

`zend_eula`

```ruby
zend_eula "accept-my-eula"
```

`zend_license`

```ruby
zend_license "#{node[:zend][:order_id]} do
  license_key node[:zend][:license_key]
  # optionally you may specify the order_id
  order_id node[:zend][:order_id]
end
```

`zend_password`

```ruby
zend_password "#{node[:zend][:gui_passwd]}"
```


### Using with vagrant

```ruby
Vagrant::Config.run do |config|
    config.vm.box = "precise64"
    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"
      chef.data_bags_path = "bags"
      chef.add_recipe "zend"
      chef.json = {
          :zend => {
              :install => "zend-server",
              :packages => {
                  'pdo-mysql' => :install,
                  'mysqli' => :install,
                  'curl' => :install,
                  'ssh2' => :install,
                  'xdebug' => :install,
                  'mongo' => :install,
                  'xsl' => :install,
                  'json' => :install,
                  'sockets' => :install,
                  'phar' => :install
              },
              :php => {
                  :version => "5.3"
              },
              :accept_eula => true,
              :gui_passwd => "vagrant",
              :order_id => "US-9999-99",
              :license_key => "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
          }
      }
    end
  end
```
