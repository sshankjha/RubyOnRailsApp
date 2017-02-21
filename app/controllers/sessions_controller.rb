class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "Successfull login"
      log_in user
      redirect_to user
    else
      flash[:notice] = "Wrong Credentials"
      render 'new'
    end
  end
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  def destroy
    log_out
    redirect_to root_url
  end
end
