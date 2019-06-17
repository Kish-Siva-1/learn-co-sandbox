class Portfolio < ActiveRecord::Base
  belongs_to :user 
  has_many :investments
  has_many :stocks, :through => :investments

  validates :name, presence: true
  validates :stock_name, presence: true
  validates :stock_weight, presence: true
  
end 