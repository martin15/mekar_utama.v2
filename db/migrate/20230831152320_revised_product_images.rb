class RevisedProductImages < ActiveRecord::Migration[5.1]
  def change
    rename_column :product_images, :product_image_file_name, :image
    remove_column :product_images, :product_image_content_type
    remove_column :product_images, :product_image_file_size
    remove_column :product_images, :product_image_updated_at
  end
end
