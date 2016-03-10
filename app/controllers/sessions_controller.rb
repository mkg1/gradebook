class SessionsController < ApplicationController
  def new
  end

  def create
    user_type = params[:user_type]
    user = user_type.constantize.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_type] = user_type

      redirect_to root_path, notice: "You have successfully logged in!"
      # redirect_to send("#{params[:user_type].downcase}s_path"), notice: "You have successfully logged in!"
    else
      flash.now[:alert] = "Login failed: invalid email or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to login_path, notice: "You have logged out."
  end
end
