class AddLowToStocks < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :low, :string
  end
end
