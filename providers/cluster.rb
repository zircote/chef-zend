zs_manage = "/usr/local/zend/bin/zs-manage"


action :add do
  Chef::Log.info "adding server to zend cluster manager"
  execute "zs-add" do
    command <<-EOF
/usr/local/zend/bin/zs-manage cluster-add-server \
-u #{new_resource.zs_url} \
-n #{new_resource.name} \
-p #{new_resource.password}  \
-r #{new_resource.server_retry} \
-w #{new_resource.wait} \
-R #{new_resource.restart} \
-P #{new_resource.propagate} \
-U #{new_resource.zcm_url} \
-N #{new_resource.key_name} \
-K #{new_resource.secret_key}
    EOF
  end
end

action :remove do
  Chef::Log.info "removing server to zend cluster manager"
  execute "zs-add" do
    force = new_resource.force ? "-f" : nil
    sync = new_resource.sync ? "-s" : nil
    command <<-EOF
/usr/local/zend/bin/zs-manage cluster-remove-server \
#{new_resource.server_id} \
-w #{new_resource.wait} \
-r #{new_resource.server_retry} \
#{force} \
#{sync}  \
-N #{new_resource.key_name} \
-K #{new_resource.secret_key} \
-R #{new_resource.restart} \
-U #{new_resource.zcm_url}
    EOF
  end
end
