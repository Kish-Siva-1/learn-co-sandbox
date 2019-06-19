class StockController < ApplicationController
  
  get '/stock/new' do 
    if logged_in?
      @stocks = Stock.all
      erb :"stock/new"
    else 
      redirect to '/login'
    end 
  end
  
  post '/stock/new' do 
    
  end
  
end 