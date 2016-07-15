if Rails.env == "production"
  TINKUY_API_USER = ENV['TINKUY_API_USER']
  TINKUY_API_PASSWORD = ENV['TINKUY_API_PASSWORD']
else
  puts "we are in development"
  TINKUY_API_USER = KEYS[:tinkuy_api_user]
  TINKUY_API_PASSWORD = KEYS[:tinkuy_api_password]
end