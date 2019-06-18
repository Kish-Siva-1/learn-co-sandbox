class CreateWeight < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.integer :portfolio_weight
    end 
  end
end
