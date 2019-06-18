class CreatePortfolio < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string  :user_id
      t.string  :name
      t.float   :stock_weight
    end
  end
end
