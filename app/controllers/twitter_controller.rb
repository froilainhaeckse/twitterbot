class TwitterController < ApplicationController
  def time
    #does the view and the method has to have the same name
  end
  def sidebar
    num_followers = {}
    twitter_screen_name = {}
    twitter_name = {}
    unless Rails.application.secrets.twitter['enabled'] == false
      # if num_followers.keys[0] == nil
      #  num_followers = {(Time.now) => twitter_client.user.followers_count}
      # else
      #   unless Time.now < num_followers.keys[0] + 15.minutes
      #     num_followers = {(Time.now) => twitter_client.user.followers_count}
      #   end
      # end
      # @num_followers = num_followers.values[0]

      if twitter_screen_name.keys[0] == nil
       twitter_screen_name = {(Time.now) => twitter_client.user.screen_name}
      else
        unless Time.now < twitter_screen_name.keys[0] + 15.minutes
          twitter_screen_name = {(Time.now) => twitter_client.user.screen_name}
        end
      end
      @twitter_screen_name = twitter_screen_name.values[0]

      if twitter_name.keys[0] == nil
       twitter_name = {(Time.now) => twitter_client.user.name}
      else
        unless Time.now < twitter_name.keys[0] + 15.minutes
          twitter_name = {(Time.now) => twitter_client.user.name}
        end
      end
      @twitter_name = twitter_name.values[0]

      # @tweets = []
      # differ between tweets and retweets! do not show retweets! retweets start with "RT"
      @tweets = twitter_client.user_timeline.select{ |tweet| tweet.text.start_with?('RT')==false}
      @tweet_time = "tweeted on" # should say retweeted on for retweet
    end
  end
end
