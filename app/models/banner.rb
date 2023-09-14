class Banner < ActiveRecord::Base
  # attr_accessible :banner_image
  mount_uploader :image, BannerUploader

  validates_presence_of :image
end
