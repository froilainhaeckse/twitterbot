class TwitterController < ApplicationController
  def time
    #does the view and the method has to have the same name
  end
  def sidebar
    @num_followers = nil
    @current_time = Time.now
    # only do when twitter_credentials are set as required
    unless Rails.application.secrets.twitter['enabled'] == false
      # if @num_followers == nil
      #   @num_followers = twitter_client.user.followers_count
      # end
      # have all the tweets in an array
      @tweets = []
      @twitter_name = twitter_client.user.screen_name
      # differ between tweets and retweets! do not show retweets! retweets start with "RT"
      @tweets = twitter_client.user_timeline.select{ |tweet| tweet.text.start_with?('RT')==false}
    end
  end
end
