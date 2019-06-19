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
    if logged_in?
      stock_names = []
      portfolio_weight = []
      params.each do |x,y|
        break if x == "id"
        n = 0
        while n < y.length 
          if !y[n].values[0].empty?   
            if x == "stock"
              stock_names << y[n]
            elsif x == "weight" 
              portfolio_weight << y[n]
            end 
          end
          n+=1 
        end
      end 
      
      @id = params[:id]
      
      k = 0
      while k < stock_names.length
        portfolio = current_user.portfolios.find(@id)
        stock_store = Stock.create(stock_names[k])
        weight_store = Weight.create(portfolio_weight[k])
        portfolio.stocks << stock_store 
        stock_store.weights << weight_store
        k += 1
      end 
      
      erb :"/portfolio/index"
    
    else 
      redirect to '/login'
    end
  end
  
end 