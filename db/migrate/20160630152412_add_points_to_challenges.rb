class AddPointsToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :point_increment, :integer
    add_column :challenges, :point_elapsed_time, :integer
    add_column :challenges, :point_updated_at, :datetime
    add_column :challenges, :solved_at, :datetime
  end
end
