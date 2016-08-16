class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter['consumer_key']
      config.consumer_secret     = Rails.application.secrets.twitter['consumer_secret']
      config.access_token        = Rails.application.secrets.twitter['access_token']
      config.access_token_secret = Rails.application.secrets.twitter['access_token_secret']
    end
  end

  #get rid of the global variables?
  def twitter_screen_name
    twitter_screen_name  = [nil, nil]
    twitter_screen_name
  end

  def twitter_name
    twitter_name  = [nil, nil]
    twitter_name
  end

end
