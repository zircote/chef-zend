Description
===========

Installs and configures [Zend Server](http://www.zend.com/en/products/server/)

Requirements
============

`zend` cookbook

Tested on
 - Ubuntu 12.04LTS x86_64
 - Centos 6.3 x86_64
 - SLES11 SP164


Attributes
==========

```ruby
default[:zend][:php][:version] = "5.3"
default[:zend][:zs_prefix] = "/usr/local/zend"
default[:zend][:server][:gui_passwd] = "vagrant"
default[:zend][:server][:accept_eula] = nil
default[:zend][:server][:gui_passwd] = nil
default[:zend][:server][:order_id] = nil
default[:zend][:server][:server_license_key] = nil
```

Usage
=====

Include the default recipe. 

To access the Administration Interface (Web) open your browser at:
<https://localhost:10082/ZendServer> (secure) or <http://localhost:10081/ZendServer>.
