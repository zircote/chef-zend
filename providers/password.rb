action :update do
  Chef::Log.info "Setting Zend Server gui password"
  execute "/usr/local/zend/bin/zs-setup set-password #{new_resource.gui_password}"
end
