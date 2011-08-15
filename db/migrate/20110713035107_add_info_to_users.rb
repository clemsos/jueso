class AddInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :bio, :text
    add_column :users, :link, :string
  end

  def self.down
    remove_column :users, :link
    remove_column :users, :bio
  end
end
