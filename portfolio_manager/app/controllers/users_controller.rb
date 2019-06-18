class UsersController < ApplicationController
  
  get '/signup' do 
    if logged_in? 
      redirect to '/portfolio'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do 
    if !logged_in?
      binding.pry
      @user = User.new(params)
      if @user.save 
        session[:user_id] = @user.id
        binding.pry
        redirect to '/portfolio'
      else 
        redirect to '/signup'
      end
    else 
      redirect to '/portfolio'
    end 
  end
  
  get '/login' do 
    if logged_in?
      redirect to '/portfolio'
    else 
      erb :'users/login'
    end 
  end
  
  post '/login' do 
    User.create(params)
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password]) && (user.username == params[:username]) 
      session[:user_id] = user.id
      redirect to '/portfolio'
    end
  end
  
  get '/logout' do 
    if logged_in?
      session.clear
      redirect to '/login'
    else 
      redirect to '/login'
    end 
  end
  
  post '/logout' do 
    redirect to '/login'
  end
  
end 