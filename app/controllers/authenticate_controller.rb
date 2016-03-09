class AuthenticateController < ApplicationController
  def login
    if request.post?
      user = Teacher.find_by(email: params[:email])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to grades_path, notice: "Login successful."
      else
        flash[:notice] = "You stink at remembering passwords."
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to authenticate_login_path, notice: "Peace."
  end
end
