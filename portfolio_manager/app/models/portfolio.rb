class Portfolio < ActiveRecord::Base
  belongs_to :user 
  has_many :investments
  has_many :stocks, :through => :investments
  
end 