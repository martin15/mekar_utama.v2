class RevisedBanners < ActiveRecord::Migration[5.1]
  def change
    rename_column :banners, :banner_image_file_name, :image
    remove_column :banners, :banner_image_content_type
    remove_column :banners, :banner_image_file_size
    remove_column :banners, :banner_image_updated_at
  end
end
