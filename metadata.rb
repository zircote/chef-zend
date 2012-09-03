maintainer       "Robert Allen"
maintainer_email "zircote@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures Zend Server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"


%w{ debian ubuntu centos redhat fedora scientific amazon suse }.each do |os|
  supports os
end

recipe "zend", "Default Zend Server Installation"

