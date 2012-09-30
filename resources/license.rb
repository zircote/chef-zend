actions :add
default_action :add

attribute :order_id, :kind_of => String, :name_attribute => true
attribute :license_key, :required => true, :kind_of => String
