class AddDeadlinesToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :deadline, :datetime
  end

  def self.down
    remove_column :projects, :deadline
  end
end
