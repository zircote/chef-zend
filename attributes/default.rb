#
# Cookbook Name:: zend
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
# zend-server: Zend Server
# zend-ce: Zend Server Community Edition
# zend-cluster-manager: Zend Server Cluster Manager
default[:zend][:install] = "zend-ce"
# 5.2|5.3|5.4?
default[:zend][:php][:version] = "5.3"
default[:zend][:application] = "zend-server-ce-php-5.3"

# Enable Logrotation
default[:zend][:log_rotate][:enable] = true
# file size to rotate
default[:zend][:log_rotate][:size] = "5M"
# keep up to {x} backup files
default[:zend][:log_rotate][:rotate] = 10
# Provisioning for License and Password
default[:zend][:gui_passwd] = "vagrant"
default[:zend][:accept_eula] = false
default[:zend][:order_id] = nil
default[:zend][:license_key] = nil

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


case node['platform']
  when "debian", "ubuntu"
    #Ubuntu/Debian
    default[:zend][:packages]['libframework1'] = [:nothing]
    default[:zend][:packages]['libinformix'] = [:nothing]
    default[:zend][:packages]['xdebug'] = [:nothing]
    default[:zend][:packages]['phpmyadmin'] = [:nothing]
end
# Centos
default[:zend][:packages]['apc'] = [:nothing]
default[:zend][:packages]['bcmath'] = [:nothing]
default[:zend][:packages]['bz2'] = [:nothing]
default[:zend][:packages]['calendar'] = [:nothing]
default[:zend][:packages]['common-extensions'] = [:nothing]
default[:zend][:packages]['ctype'] = [:nothing]
default[:zend][:packages]['curl'] = [:nothing]
default[:zend][:packages]['exif'] = [:nothing]
default[:zend][:packages]['extra-extensions'] = [:nothing]
default[:zend][:packages]['fileinfo'] = [:nothing]
default[:zend][:packages]['ftp'] = [:nothing]
default[:zend][:packages]['gd'] = [:nothing]
default[:zend][:packages]['gettext'] = [:nothing]
default[:zend][:packages]['gmp'] = [:nothing]
default[:zend][:packages]['ibmdb2'] = [:nothing]
default[:zend][:packages]['imagick'] = [:nothing]
default[:zend][:packages]['imap'] = [:nothing]
default[:zend][:packages]['intl'] = [:nothing]
default[:zend][:packages]['json'] = [:nothing]
default[:zend][:packages]['ldap'] = [:nothing]
default[:zend][:packages]['mbstring'] = [:nothing]
default[:zend][:packages]['mcrypt'] = [:nothing]
default[:zend][:packages]['memcache'] = [:nothing]
default[:zend][:packages]['memcached'] = [:nothing]
default[:zend][:packages]['mongo'] = [:nothing]
default[:zend][:packages]['mssql'] = [:nothing]
default[:zend][:packages]['mysql'] = [:nothing]
default[:zend][:packages]['mysqli'] = [:nothing]
default[:zend][:packages]['oci8'] = [:nothing]
default[:zend][:packages]['odbc'] = [:nothing]
default[:zend][:packages]['pcntl'] = [:nothing]
default[:zend][:packages]['pdo-dblib'] = [:nothing]
default[:zend][:packages]['pdo-ibm'] = [:nothing]
default[:zend][:packages]['pdo-informix'] = [:nothing]
default[:zend][:packages]['pdo-mysql'] = [:nothing]
default[:zend][:packages]['pdo-oci'] = [:nothing]
default[:zend][:packages]['pdo-odbc'] = [:nothing]
default[:zend][:packages]['pdo-pgsql'] = [:nothing]
default[:zend][:packages]['pgsql'] = [:nothing]
default[:zend][:packages]['phar'] = [:nothing]
default[:zend][:packages]['posix'] = [:nothing]
default[:zend][:packages]['shmop'] = [:nothing]
default[:zend][:packages]['soap'] = [:nothing]
default[:zend][:packages]['sockets'] = [:nothing]
default[:zend][:packages]['sqlite'] = [:nothing]
default[:zend][:packages]['ssh2'] = [:nothing]
default[:zend][:packages]['sysvmsg'] = [:nothing]
default[:zend][:packages]['sysvsem'] = [:nothing]
default[:zend][:packages]['sysvshm'] = [:nothing]
default[:zend][:packages]['thrift'] = [:nothing]
default[:zend][:packages]['tidy'] = [:nothing]
default[:zend][:packages]['tokenizer'] = [:nothing]
default[:zend][:packages]['unix-extensions'] = [:nothing]
default[:zend][:packages]['uploadprogress'] = [:nothing]
default[:zend][:packages]['wddx'] = [:nothing]
default[:zend][:packages]['xmlrpc'] = [:nothing]
default[:zend][:packages]['xsl'] = [:nothing]
default[:zend][:packages]['zip'] = [:nothing]
