class Product < ActiveRecord::Base
  SHAPE = ["Hexagonal", "Trigonal", "Round"]

  has_permalink :name, :update => true

  has_many :product_images, dependent: :destroy, inverse_of: :product
  belongs_to :category

  accepts_nested_attributes_for :product_images, :allow_destroy => true

  # has_attached_file :image, :url => "/system/:attachment/:id/:style/:basename.:extension", 
  #                           :styles => { :thumb => "125x125",
  #                                        :medium => "300x300",
  #                                        :large => "600x600" }
  # validates_attachment_presence :image
  validates :name, presence: true, length: {minimum: 1, maximum: 254}

  def category_name
    self.try(:category).try(:name)
  end

  def primary_image(size)
    puts product_images.inspect
    img = product_images.primary.first
    return "/undefined" if img.nil?
    img.image.url(size.to_sym)
  end

  def unset_primary
    product_images.each do |image|
      if image.is_primary?
        image.is_primary = false
        image.save!
      end
    end
  end

end
