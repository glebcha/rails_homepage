require "instagram"

  Instagram.configure do |config|
    config.client_id = ENV["instagram_client_id"]
    config.access_token = ENV["instagram_access_token"]
  end