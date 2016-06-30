class AddUserToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :division_id, :integer
    add_column :challenges, :user_id, :integer
  end
end
