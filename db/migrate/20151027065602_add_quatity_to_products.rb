class AddQuatityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :quantity, :integer, default: 0
  end
end