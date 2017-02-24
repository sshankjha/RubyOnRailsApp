class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    if logged_in?
      redirect_to user_path(current_user[:id])
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "Successfull login"
      if user.is_admin
        log_in user
        redirect_to admin_path(user.id)
      else
        log_in user
        redirect_to user
      end
    else
      flash[:notice] = "Wrong credentials"
      render 'new'
    end

  end
  def log_out
    session.delete(:user_id)
    puts :user_id
    @current_user = nil
    redirect_to root_url
  end
end
