class AddSharesToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :shares, :integer
    add_column :challenges, :share_increment, :integer
    add_column :challenges, :share_decrement, :integer
    add_column :challenges, :elapsed_time, :integer
    add_column :challenges, :share_updated_at, :datetime
  end
end
