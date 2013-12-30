class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :update_profile]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      respond_to do |format|
        format.html { redirect_to settings_path, notice: 'Bienvenido!' }
        format.json { render action: 'show', status: :created, location: @user }
      end
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        if is_admin?
          format.html { redirect_to users_url, notice: 'Información actualizada.' }
        else
          format.html { redirect_to settings_path, notice: 'Información actualizada.' }
        end
      else
        format.html { redirect_to change_password_path(@user), notice: 'Contraseña incorrecta, asegúrate que sean idénticas.' }
      end
    end
  end

  def update_profile
    respond_to do |format|
      if @user.update(user_params_profile)
        if is_admin?
          format.html { redirect_to settings_path, notice: 'Perfil actualizado exitosamente.' }
        else
          format.html { redirect_to settings_path, notice: 'Perfil actualizado exitosamente.' }
        end
      else
        format.html { redirect_to settings_path, notice: 'Algo anduvo mal.' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if !params[:id].nil?
        @user = User.find(params[:id])
      elsif !current_user.nil?
        @user = User.find(current_user.id)
      else
        redirect_to signin_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :phone, :title, :password, :password_confirmation)
      #params.require(:user).permit(:name, :email, :phone, :title, :user_type, :password_digest, :remember_token)
    end

    def user_params_profile
      params.require(:user).permit(:name, :email, :phone, :title)
    end
end