#
# Cookbook Name:: processor
# Recipe:: cleanup
#

# reload monit
execute "reload-monit" do
  command "monit quit && telinit q"
  action :nothing
end

unless util?
  # report to dashboard
  ey_cloud_report "processor" do
    message "Cleaning up processor (if needed)"
  end

  if app_server? || util?
    # loop through applications
    node[:applications].each do |app_name, _|
      # monit
      file "/etc/monit.d/processor_#{app_name}.monitrc" do
        action :delete
        notifies :reload, resources(:execute => "reload-monit")
      end

      # yml files
      node[:processor][:workers].times do |count|
        file "/data/#{app_name}/shared/config/processor_#{count}.yml" do
          action :delete
        end
      end
    end

    # bin script
    file "/engineyard/bin/processor" do
      action :delete
    end

    # stop processor
    execute "kill-processor" do
      command "pkill -f processor"
      only_if "pgrep -f processor"
    end
  end
end
