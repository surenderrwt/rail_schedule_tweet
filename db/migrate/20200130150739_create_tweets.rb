class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.text :content, length: { maximum: 140 }, null: false
      t.datetime :send_at, null: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
