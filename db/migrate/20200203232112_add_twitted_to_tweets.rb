class AddTwittedToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :tweeted, :boolean, default: false
  end
end
