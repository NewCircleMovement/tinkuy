Koudoku.setup do |config|
  config.webhooks_api_key = "182d32f8-67e1-474a-bad1-eb01be5cbfa7"
  config.subscriptions_owned_by = :user

  if Rails.env == "production"
    # set credentials from ENV hash
    # STRIPE_CREDENTIALS = { 
    #   :stripe_publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    #   :stripe_secret_key => ENV['STRIPE_SECRET_KEY']
    # }
    config.stripe_publishable_key = ENV['STRIPE_PUBLISHABLE_KEY']
    config.stripe_secret_key = ENV['STRIPE_SECRET_KEY']
  else
    # get credentials from YML file if exists
    yml_file = Rails.root.join("config/stripe.yml")
    if File.exists? yml_file
      STRIPE_CREDENTIALS = YAML.load_file(yml_file)[Rails.env].try(:symbolize_keys)
      config.stripe_publishable_key = STRIPE_CREDENTIALS[:STRIPE_PUBLISHABLE_KEY]
      config.stripe_secret_key = STRIPE_CREDENTIALS[:STRIPE_SECRET_KEY]
    end
  end

  # config.prorate = false # Default is true, set to false to disable prorating subscriptions
  # config.free_trial_length = 30
end
