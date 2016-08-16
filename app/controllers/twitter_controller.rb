class TwitterController < ApplicationController
  def time
    #does the view and the method has to have the same name
  end
  def sidebar
    unless Rails.application.secrets.twitter['enabled'] == false
      @twitter_screen_name = load_from_cache(twitter_screen_name, "screen_name")
      @twitter_name = load_from_cache(twitter_name, "name")

      # differ between tweets and retweets! do not show retweets! retweets start with "RT"
      @tweets = twitter_client.user_timeline.select{ |tweet| tweet.text.start_with?('RT')==false}
      @tweet_time = "tweeted on"
    end
  end

  # cache because of twitter API rate limit
  def load_from_cache(tuple, twitter_user_property)
    if tuple[0] == nil
      update_time_based_cache(tuple, twitter_user_property)
    else
      unless Time.now < tuple[0] + 15.minutes
        update_time_based_cache(tuple, twitter_user_property)
      end
    end
    tuple[1]
  end

  # talk to twitter API
  def update_time_based_cache(tuple, twitter_user_property)
    tuple[0] = Time.now
    tuple[1] = twitter_client.user[twitter_user_property]
  end

end
