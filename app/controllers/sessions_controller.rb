class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.is_admin
      redirect_to root_path
    else
      if user && user.authenticate(params[:session][:password])
        flash[:notice] = "Successfull login"
        log_in user
        redirect_to user
      else
        flash[:notice] = "Wrong Credentials"
        render 'new'
      end
    end

  end
  def log_out
    session.delete(:user_id)
    puts :user_id
    @current_user = nil
    redirect_to root_url
  end
end
