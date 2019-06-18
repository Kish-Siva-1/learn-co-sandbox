class PortfolioController < ApplicationController
  
  get '/portfolio' do 
    if logged_in?
      @user = current_user 
      @portfolios = Portfolio.all
      erb :"/portfolio/index"
    else 
      redirect to '/login'
    end 
  end 
  
  get '/portfolio/new' do 
    if logged_in?
      erb :"portfolio/new"
    else 
      redirect to '/login'
    end 
  end 
  
  post '/tweets/new' do 
    
    if logged_in?  
      if (params[:content] != "")
        @tweet = current_user.tweets.build(params)
        @tweet.save
      end
    else 
      redirect to '/login'
    end
    
  end 

  post '/tweets' do
    if logged_in? 
      erb :"/tweets/tweets"
    else 
      redirect to '/login'
    end 
  end
  
  get '/tweets/:id' do 
    if logged_in?
      erb :'users/show'
    else 
      redirect to '/login'
    end 
  end
  
  get '/tweets/:id/edit' do 
    if logged_in?
      erb :'tweets/edit_tweet'
    else 
      redirect to '/login'
    end 
  end
  
  patch '/tweets/:id' do
    if logged_in? 
      @tweet = Tweet.find_by_id(params[:id])
      if (params[:content] != "") && (current_user.id == @tweet.user_id) 
        @tweet.content = params[:content]
        @tweet.save
      else 
        redirect to "/tweets/#{current_user.id}/edit"
      end 
    else 
      redirect to '/login'
    end 
  end
  
  delete '/tweets/:id/delete' do
    if logged_in? 
      @tweet = Tweet.find_by_id(params[:id])
      if (params[:content] != "") && (current_user.id == @tweet.user_id) 
        @tweet.delete
      else 
        redirect to "/tweets/#{current_user.id}/edit"
      end 
    else 
      redirect to '/login'
    end
  end
  
end 