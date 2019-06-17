class Stock < ActiveRecord::Base
  has_many :investments
  has_many :portfolios, :through => :investments

end 