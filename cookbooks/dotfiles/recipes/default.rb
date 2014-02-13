#
# Cookbook Name:: dotfiles
# Recipe:: default
#

if ['solo', 'app', 'app_master', 'util'].include?(node[:instance_role])
  node[:applications].each do |app_name, data|
    username = node[:users].first[:username]
    template "/home/#{username}/.irbrc" do
      source "irbrc.erb"
      owner username
      group username
      mode 0744
    end

    template "/home/#{username}/.bashrc" do
      source "bashrc.erb"
      owner username
      group username
      mode 0744
      variables({
        :app_name => app_name
      })
    end
  end
end
