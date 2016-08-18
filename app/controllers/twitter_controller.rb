class TwitterController < ApplicationController
  def time
    #does the view and the method has to have the same name
  end
  def sidebar
    unless Rails.application.secrets.twitter['enabled'] == false

      user_info = load_from_cache
      @twitter_screen_name = user_info[:screen_name]
      @twitter_name = user_info[:name]

      # ***cashing also tweets!
      @tweets = twitter_client.user_timeline.select{ |tweet| tweet.text.start_with?('RT','@')==false}
      @tweet_time = "tweeted on"
    end
  end

  # cache because of twitter API rate limit
  def load_from_cache
    if $twitter_user_info[0] == nil
      update_time_based_cache
    else
      unless Time.now < $twitter_user_info[0] + 15.minutes
        update_time_based_cache
      end
    end
    $twitter_user_info[1]
  end

  # talk to twitter API
  def update_time_based_cache
    $twitter_user_info[0] = Time.now
    # * fetch data once and put in a hash
    user_info = twitter_client.user
    # tweets in array in the hash
    $twitter_user_info[1] = {screen_name: user_info['screen_name'], name: user_info['name']}
  end

end
