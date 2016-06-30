class AddShareNumberToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :share_number, :integer
  end
end
