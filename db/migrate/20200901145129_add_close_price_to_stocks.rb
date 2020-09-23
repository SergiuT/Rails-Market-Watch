class AddClosePriceToStocks < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :close_price, :decimal
  end
end
