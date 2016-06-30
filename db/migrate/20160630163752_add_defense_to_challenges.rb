class AddDefenseToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :defense_point_increment, :integer
    add_column :challenges, :defense_elapsed_time, :integer
    add_column :challenges, :defense_updated_at, :datetime
  end
end
