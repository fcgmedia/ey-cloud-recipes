#
# Cookbook Name:: sidekiq
# Recipe:: default
#

include_recipe "processor::cleanup"
include_recipe "processor::setup"
