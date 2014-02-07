# place database credentials in this file
#
#   default[app_name] = { :adapter => '', :database => '', :username => '', :password => '', :host => '' }
#
# for example:
#
default[:rds] = {
  :adapter => 'mysql',
  :database => "ENV['RDS_MASTER_DB_NAME']",
  :username => "ENV['RDS_MASTER_USERNAME']",
  :password => "ENV['RDS_MASTER_PASSWORD",
  :host => "ENV['RDS_MASTER_HOST']"
}
