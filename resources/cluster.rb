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
