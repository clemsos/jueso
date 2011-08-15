class AddImagesToUpdates < ActiveRecord::Migration
    def self.up
      add_column :updates, :data_file_name,    :string
      add_column :updates, :data_content_type, :string
      add_column :updates, :data_file_size,    :integer
      add_column :updates, :data_updated_at,   :datetime
    end

    def self.down
      remove_column :updates, :data_file_name
      remove_column :updates, :data_content_type
      remove_column :updates, :data_file_size
      remove_column :updates, :data_updated_at
    end
end
