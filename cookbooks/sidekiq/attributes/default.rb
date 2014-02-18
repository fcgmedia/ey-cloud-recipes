#
# Cookbook Name:: sidekiq
# Attrbutes:: default
#

default[:sidekiq] = {
  # Sidekiq will be installed on to application/solo instances,
  # unless a utility name is set, in which case, Sidekiq will
  # only be installed on to a utility instance that matches
  # the name
  :utility_name => 'worker',

  # Number of workers (not threads)
  :workers => node[:environment][:framework_env] == "production" ? 2 : 1,

  # Concurrency
  :concurrency => node[:environment][:framework_env] == "production" ? 25 : 5,

  # Queues
  :queues => {
    # :queue_name => priority
    :most_viewed => 3,
    :email => 3,
    :high => 6,
    :default => 2,
    :low => 1
  },

  # Verbose
  :verbose => false
}
