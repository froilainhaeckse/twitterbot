class TwitterController < ApplicationController
  def test
      @current_time = Time.now
    # only do when twitter_credentials are set as required
    unless Rails.application.secrets.twitter_required == false
        # have all the tweets in an array
        @num_followers = twitter_client.user.followers_count
        @tweets = []
        @twitter_name = twitter_client.user.screen_name
        # twitter_client.user_timeline.each do |tweet|
        #   unless tweet.text.start_with?('RT')
        #     @tweets << tweet.text
        #   end
        # end
          # differ between tweets and retweets! do not show retweets! retweets start with "RT"
          @tweets = twitter_client.user_timeline.select{ |tweet| tweet.text.start_with?('RT')==false}
    end
  end
end
