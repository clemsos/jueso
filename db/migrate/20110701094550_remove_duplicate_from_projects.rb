class RemoveDuplicateFromProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :morelinks
    remove_column :projects, :rewards
    add_column :projects, :video_link, :string
  end

  def self.down
    add_column :projects, :morelinks, :text
    add_column :projects, :rewards, :text
    remove_column :projects, :video_link
  end
end
