class CreateInvestment < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.string :portfolio_id
      t.string :stock_id
    end
  end
end
