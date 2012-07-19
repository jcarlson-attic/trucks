class MoveUnitPriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :unit_price, :integer
    remove_column :line_items, :unit_price
  end
end
