#
# Cookbook Name:: ironio_processor
# Attrbutes:: default
#

default[:processor] = {
  # processor will be installed on to application/solo instances,
  # unless a utility name is set, in which case, processor will
  # only be installed on to a utility instance that matches
  # the name
  :utility_name => 'processor',
  :workers => 2
}

# Store processor node as attribute
util = node[:engineyard][:environment][:instances].find{|i| i[:name].to_s == default[:processor][:utility_name]}
Chef::Log.info "PROCESSOR INSTANCE: #{util.inspect}"

default[:processor][:host] = util ? util[:private_hostname] : '127.0.0.1'
Chef::Log.info "PROCESSOR HOST: #{default[:processor][:host]}"
