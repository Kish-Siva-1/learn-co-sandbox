class PortfolioController < ApplicationController
  
  get '/portfolio' do 
    if logged_in?
      @portfolios = Portfolio.all
      erb :"/portfolio/index"
    else 
      redirect to '/login'
    end 
  end 
  
  get '/portfolio/new' do 
    if logged_in?
      @stocks = Stock.all
      @portfolios = Portfolio.all
      erb :"portfolio/new"
    else 
      redirect to '/login'
    end 
  end 
  
  post '/portfolio/new' do 
    if logged_in?  
      if !params[:portfolio].empty?
        portfolio = current_user.portfolios.create(params[:portfolio])
        binding.pry
        portfolio.weights << Weight.create(params[:weight])
        Stock.all.last.weights << portfolio.weights 
        if !params[:stock][:name].empty?
          portfolio.stocks << Stock.create(params[:stock]) 
        end 
      end 
        erb :"/portfolio/index"
    else 
      redirect to '/login'
    end
    
  end 
  
  get '/portfolio/:id' do 
    @portfolio = Portfolio.find(params[:id])
    if logged_in?
      erb :'portfolio/show'
    else 
      redirect to '/users/login'
    end 
  end
  
  get '/portfolio/:id/edit' do 
    if logged_in?
      @portfolio = Portfolio.find(params[:id])
      @stocks = Stock.all
      erb :'portfolio/edit'
    else 
      redirect to '/login'
    end 
  end
  
  patch '/portfolio/:id' do
    if logged_in?  
      if !params[:portfolio][:stock_weight].empty?
        portfolio = Portfolio.find(params[:id])
        portfolio.update(params[:portfolio]) 
      end 
        erb :"/portfolio/index"
    else 
      redirect to '/login'
    end
  end
  
  delete '/portfolio/:id/delete' do
    if logged_in? 
      @portfolio = Portfolio.find(params[:id])
      if current_user.id == @portfolio.user_id.to_i
        @portfolio.delete
        redirect to "/portfolio"
      else 
        redirect to "/portfolio/#{current_user.id}/edit"
      end 
    else 
      redirect to '/login'
    end
  end
  
end 