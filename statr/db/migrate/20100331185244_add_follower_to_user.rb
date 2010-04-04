class AddFollowerToUser < ActiveRecord::Migration
  def self.up
    create_table :followees, :force => true, :id => false do |t|
      t.integer :followee_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :followees
  end
end