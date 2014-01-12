#
# Cookbook Name:: sidekiq
# Recipe:: default
#

include_recipe "message_processor::cleanup"
include_recipe "message_processor::setup"
