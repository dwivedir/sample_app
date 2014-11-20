class SessionsController < ApplicationController
  
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination"
      @title = "Sing in"
      render 'new'
    else
      log_in user
      redirect_back_or user
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
