class CreateBetaInvites < ActiveRecord::Migration
  def self.up
    create_table :beta_invites do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :beta_invites
  end
end
