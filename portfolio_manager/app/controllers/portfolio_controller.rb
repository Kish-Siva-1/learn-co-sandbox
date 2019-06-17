class PortfolioController < ApplicationController
  
  get '/portfolio' do 
    if logged_in?
      erb :"/portfolio/index"
    else 
      erb :"/login"
    end 
  end 
  
  get '/new' do 
    
  end
  
end 