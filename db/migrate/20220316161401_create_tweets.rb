class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :retweets
      t.integer :likes

      t.timestamps
    end
  end
end
