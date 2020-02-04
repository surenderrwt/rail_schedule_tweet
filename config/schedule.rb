every 1.minute do 
  rake "instweet:post_tweet", :environment => 'development' 
 end