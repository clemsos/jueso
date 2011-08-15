class AddStatesToProposals < ActiveRecord::Migration
  def self.up
    change_table :proposals do |t|
      t.text :state
    end
  end

  def self.down
    remove_column :proposals, :state
  end
end
