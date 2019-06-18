class Weight < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio
  
end 