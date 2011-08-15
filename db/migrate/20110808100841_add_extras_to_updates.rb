class AddExtrasToUpdates < ActiveRecord::Migration
  def self.up
    add_column :updates, :state, :string
  end

  def self.down
    remove_column :projects, :video_link, :string
  end
end
