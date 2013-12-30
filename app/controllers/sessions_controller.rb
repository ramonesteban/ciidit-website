class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to settings_path
    else
      render 'new', locals: { msg_login_failed: 'Correo o Contraseña incorrecta.' }
    end
  end

  def destroy
    sign_out
    redirect_to settings_path
  end
end