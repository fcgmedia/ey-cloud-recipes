#
# Cookbook Name:: le
# Recipe:: configure
#

execute "le register --account-key" do
  command "le register --account-key #{node[:le_api_key]} --name #{node[:applications].keys.first}"
  action :run
  not_if { File.exists?('/etc/le/config') }
end

follow_paths = [
  "/data/#{app_name}/shared/log/processor_0.log",
  "/data/#{app_name}/shared/log/processor_1.log",
  "/data/#{app_name}/shared/log/sidekiq_0.log"
]
# (node[:applications] || []).each do |app_name, app_info|
  # follow_paths << "/var/log/nginx/#{app_name}.access.log"
# end

follow_paths.each do |path|
  execute "le follow #{path}" do
    command "le follow #{path}"
    ignore_failure true
    action :run
  end
end
