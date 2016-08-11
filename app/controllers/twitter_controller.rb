class TwitterController < ApplicationController
  def time
    #does the view and the method has to have the same name
  end
  def sidebar
    @num_followers = nil
    @current_time = Time.now
    # only do when twitter_credentials are set as required
    unless Rails.application.secrets.twitter['enabled'] == false
      # create hash-cache, hash with timestamp; key + value
      # @myCache = {'Time.now' ==> 'twitter_client.user.followers_count'}
      # if @num_followers == nil
      #   @num_followers = twitter_client.user.followers_count
      # end
      # have all the tweets in an array
      @tweets = []
      unless @twitter_screen_name != nil
        @twitter_screen_name = twitter_client.user.screen_name # how often can this be asked for?
      end
      unless @twitter_name != nil
        @twitter_name = twitter_client.user.name # how often can this be asked for?
      end
      # differ between tweets and retweets! do not show retweets! retweets start with "RT"
      @tweets = twitter_client.user_timeline.select{ |tweet| tweet.text.start_with?('RT')==false}
      @tweet_time = "tweeted on" # should say retweeted on for retweet
    end
  end
end
