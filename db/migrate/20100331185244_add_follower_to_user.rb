class AddFollowerToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :follower_id, :integer
    add_column :users, :followee_id, :integer
  end

  def self.down
    remove_column :users, :followee_id
    remove_column :users, :follower_id
  end
end