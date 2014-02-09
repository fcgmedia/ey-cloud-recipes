#
# Cookbook Name:: cronjobs
# Recipe:: default

ey_cloud_report "cronjobs" do
  message "setting this bad boy up"
end

if node[:name] == 'houston'
  cron "#{app_name}-maintenance" do
    minute '*/5'
    user 'deploy'
    command "cd /data/#{appname}/current && RAILS_ENV=#{node[:environment][:name]} bin/rake maintenance:make_past_parties_inactive"
  end
end

