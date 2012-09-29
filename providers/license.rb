action :add do
  Chef::Log.info "provisioning the Zend Server License"
  execute "/usr/local/zend/bin/zs-setup set-license" do
    command <<-EOF
/usr/local/zend/bin/zs-setup set-license \
#{new_resource.order_id} #{new_resource.license_key}
    EOF
  end
end
