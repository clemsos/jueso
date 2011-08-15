class AddThumbnailsToLeads < ActiveRecord::Migration

    def self.up
        add_column :leads, :featimage_file_name,    :string
        add_column :leads, :featimage_content_type, :string
        add_column :leads, :featimage_file_size,    :integer
        add_column :leads, :featimage_updated_at,   :datetime
      end

      def self.down
        remove_column :leads, :featimage_file_name
        remove_column :leads, :featimage_content_type
        remove_column :leads, :featimage_file_size
        remove_column :leads, :featimage_updated_at
      end
      
end
