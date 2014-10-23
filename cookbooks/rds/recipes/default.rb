#
# Cookbook Name:: rds
# Recipe:: default
#
# Configure application servers to use an Amazon RDS database (or any external ActiveRecord-compatible database)
# Note: This recipe does not make any changes to Engine Yard-provisioned databases

enable_package 'dev-python/python-exec' do
  version '0.2'
end

enable_package 'dev-db/postgresql-base' do
  version '9.3.3'
end

enable_package 'dev-db/postgresql-server' do
  version '9.3.3'
end

package 'dev-db/postgresql-server' do
  version '9.3.3'
  action :install
end

bash "set postgresql as 9.3" do
  user "root"
  code "eselect postgresql set 9.3"
  not_if { "which psql93" }
end

if ['solo', 'app_master', 'app', 'util'].include?(node[:instance_role])
  # for each application
  node.engineyard.apps.each do |app|
    # retrieve attributes
    attributes = node[app.name]

    # skip if there are no attributes for this app
    next if attributes.nil?

    ey_cloud_report "RDS" do
      message "RDS - Replacing database.yml for #{app.name}"
    end

    # create new database.yml with attributes
    template "/data/#{app.name}/shared/config/database.yml" do
      owner node[:owner_name]
      group node[:owner_name]
      backup false
      mode 0644
      source 'database.yml.erb'
      variables({
        :environment => node[:environment][:framework_env],
        :adapter => attributes[:adapter],
        :database => attributes[:database],
        :username => attributes[:username],
        :password => attributes[:password],
        :pool => attributes[:pool],
        :host => attributes[:host]
      })
    end
  end
end
