class News < ActiveRecord::Base
  # attr_accessible :title, :content, :news_image
  has_permalink :title, :update => true
  #validates_attachment_presence :news_image
  validates :title, :presence => true,
                    :length => {:minimum => 1, :maximum => 254}
  validates :content, :presence => true

end
