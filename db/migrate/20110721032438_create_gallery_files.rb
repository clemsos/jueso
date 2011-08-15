class CreateGalleryFiles < ActiveRecord::Migration
    def self.up
      create_table :galleries_files do |t|
        
        t.integer :upload_id
        t.integer :gallery_id

        t.timestamps
      end
        add_index :galleries_files, :gallery_id
    end

    def self.down
      drop_table :galleries_files
    end
  end
