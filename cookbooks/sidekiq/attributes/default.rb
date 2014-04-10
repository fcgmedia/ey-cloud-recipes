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
  :workers => 2,

  # Concurrency
  :concurrency => node[:environment][:framework_env] == "production" ? 10 : 5,

  # Queues
  :queues => {
    # :queue_name => priority
    :most_viewed => 3,
    :email => 3,
    :activities => 5,
    :high => 6,
    :default => 2,
    :low => 1
  },

  # Verbose
  :verbose => false
}
