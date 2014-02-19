#
# Cookbook Name:: nginx
# Recipe:: default
#
#/etc/nginx/servers/app_name/custom.conf
if app_server?
  # report to dashboard
  ey_cloud_report "Nginx" do
    message "Setting up Nginx"
  end

  node[:applications].each do |app_name, _|
    # reload monit
    execute "restart-nginx-for-#{app_name}" do
      command "/etc/init.d/nginx reload"
      action :nothing
    end

    # monit
    template "/data/nginx/servers/#{app_name}/custom.conf" do
      mode 0644
      source "custom.conf.erb"
      backup false
      notifies :run, resources(:execute => "restart-nginx-for-#{app_name}")
    end
  end
end
