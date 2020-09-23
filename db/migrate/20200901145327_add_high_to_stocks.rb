class AddHighToStocks < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :high, :decimal
  end
end
