module Settings
  File.read(File.join('config', 'env.sh')).scan(/(.*?)\s*=\s*"?(.*)"?$/).each do |key, value|
    ENV[key] ||= value
  end

  HOST            = ENV['APP_HOST']
  NAME            = ENV['APP_NAME']
  DESCRIPTION     = ENV['APP_DESCRIPTION']
  AUTHOR          = ENV['APP_AUTHOR']
  REDIS_URL       = ENV['REDIS_URL']
  MALONE_URL      = ENV['MALONE_URL']
  MAIL_FROM       = ENV['MAIL_FROM']
  REMEMBER_EXPIRE = 5184000 # 60 days in seconds
end
