class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :make
      t.string :model
      t.string :description

      t.timestamps
    end
  end
end
