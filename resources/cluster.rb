actions :add, :remove

default_action :add

attribute :name, :kind_of => String, :name_attribute => true

attribute :key_name, :required => true, :kind_of => String
attribute :secret_key, :kind_of => String
attribute :zcm_url, :kind_of => String, :default => "http://localhost:10081/ZendServer"

attribute :zs_url, :kind_of => String, :default => "http://localhost:10081/ZendServerManager"
attribute :password, :kind_of => String
attribute :restart, :default => false, :kind_of => [Integer, FalseClass], :default => 0
attribute :propagate, :default => false, :kind_of => [Integer, FalseClass], :default => 0
attribute :server_retry, :default => 3, :kind_of => Integer, :default => 3
attribute :wait, :default => 5, :kind_of => Integer, :default => 5


attribute :server_id, :kind_of => String
attribute :sync, :default => false, :kind_of => [Integer, FalseClass], :default => false
attribute :force, :default => false, :kind_of => [Integer, FalseClass], :default => false
