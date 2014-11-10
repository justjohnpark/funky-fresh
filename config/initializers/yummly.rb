
Yummly.configure do |config|
  config.app_id = ENV['YUM_ID']
  config.app_key = ENV['YUM_KEY']
  config.use_ssl = false # Default is false
end