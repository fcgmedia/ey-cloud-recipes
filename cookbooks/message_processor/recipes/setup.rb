#
# Cookbook Name:: processor
# Recipe:: setup
#

if util?
  # report to dashboard
  ey_cloud_report "processor" do
    message "Setting up processor"
  end

  # bin script
  template "/engineyard/bin/processor" do
    mode 0755
    source "processor.erb"
    backup false
    variables({
      :user => node[:owner_name]
    })
  end

  # loop through applications
  node[:applications].each do |app_name, _|
    # reload monit
    execute "restart-processor-for-#{app_name}" do
      command "monit reload && sleep 1 && monit restart all -g #{app_name}_processor"
      action :nothing
    end

    # monit
    template "/etc/monit.d/processor_#{app_name}.monitrc" do
      mode 0644
      source "processor.monitrc.erb"
      backup false
      variables({
        :app_name => app_name,
        :workers => node[:processor][:workers],
        :rails_env => node[:environment][:framework_env],
        :memory_limit => 400 # MB
      })
      notifies :run, resources(:execute => "restart-processor-for-#{app_name}")
    end
  end
end
