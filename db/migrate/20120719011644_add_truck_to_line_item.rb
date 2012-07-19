class AddTruckToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :truck_id, :integer
  end
end
