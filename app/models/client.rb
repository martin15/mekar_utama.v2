class Client < ActiveRecord::Base
  # attr_accessible :client_image, :name, :best_client
  has_permalink :name, :update => true
  mount_uploader :image, ClientUploader

  validates :name, :presence => true,
                   :length => {:minimum => 1, :maximum => 254}
end
