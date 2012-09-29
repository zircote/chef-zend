action :accept do
  Chef::Log.info "accepting Zend Server EULA:"
  execute "/usr/local/zend/bin/zs-setup accept-eula"
end
