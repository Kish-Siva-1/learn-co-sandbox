class User < ActiveRecord::Base

  has_many :portfolios 
 
  validates :username, presence: true
  validates :email, presence: true
  
  has_secure_password
  
  def slug 
    self.username.split(" ").join("-")
  end 
  
  def self.find_by_slug(slug)
    self.all.find_by(username: slug.sub("-"," "))
  end 
  
end 