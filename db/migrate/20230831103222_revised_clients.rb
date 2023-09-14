class RevisedClients < ActiveRecord::Migration[5.1]
  def change
    rename_column :clients, :client_image_file_name, :image
    remove_column :clients, :client_image_content_type
    remove_column :clients, :client_image_file_size
    remove_column :clients, :client_image_updated_at
  end
end
