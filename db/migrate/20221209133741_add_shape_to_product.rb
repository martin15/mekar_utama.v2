class AddShapeToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :shape, :string
  end
end
