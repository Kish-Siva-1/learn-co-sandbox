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
      if !params[:portfolio][:stock_weight].empty?
        portfolio = current_user.portfolios.build(params[:portfolio])
        portfolio.save
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
    @portfolios = Portfolio.all
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
      @portfolios = Portfolio.find_by_id(params[:id])
      if (params[:content] != "") && (current_user.id == @portfolios.user_id) 
        @portfolios.content = params[:content]
        @portfolios.save
      else 
        redirect to "/portfolio/#{current_user.id}/edit"
      end 
    else 
      redirect to '/login'
    end 
  end
  
  delete '/portfolio/:id/delete' do
    if logged_in? 
      @portfolios = Portfolio.find_by_id(params[:id])
      if (params[:content] != "") && (current_user.id == @portfolios.user_id) 
        @portfolios.delete
      else 
        redirect to "/portfolios/#{current_user.id}/edit"
      end 
    else 
      redirect to '/login'
    end
  end
  
end 