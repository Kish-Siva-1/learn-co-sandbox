class StockController < ApplicationController
  
  get '/stock/new/:id' do
    if logged_in?
      @stocks = Stock.all
      @id = params[:id]
      erb :"stock/new"
    else 
      redirect to '/login'
    end 
  end
  
  post '/stock/new/:id' do 
    store = {}
    n = 0
    params.each do |x,y|
      break if x == "id"
      store[x] = y.reject{|_,v| v.blank?}
    end 
    
    binding.pry
    @id = params[:id]
    
    if logged_in?  
        portfolio = current_user.portfolios(@id).create(store["stock"])
        Stock.create(store["stock"]).weights.create(store["weight"])
        portfolio.stocks << Stock.all.last
        erb :"/portfolio/index"
    else 
      redirect to '/login'
    end
  end
  
end 