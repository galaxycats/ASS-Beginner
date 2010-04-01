class CreateMentions < ActiveRecord::Migration
  def self.up
    create_table :mentions, :force => true do |t|
      t.integer :message_id
      t.integer :mentioning_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mentions
  end
end