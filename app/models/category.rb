class Category < ActiveRecord::Base
  has_permalink :name, :update => true

  has_many :products
  has_many :child_categories, class_name: "Category", foreign_key: :parent_id
  belongs_to :parent_category, class_name: "Category", foreign_key: :parent_id

  def self.parent_categories
    where("parent_id is null")
  end

  def self.category_list
    all.map{|category| [category.name, category.id]}
  end

  def self.child_categories
    where("parent_id is not null")
  end

  def parent_category_name
    parent_category.try(:name)
  end
end
