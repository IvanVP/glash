class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_user!, except [:index, :show]
  before_action :goto_root , only: [:new, :create, :edit]
  before_action :check_user, only: [:update, :destroy, :avatar, :load_avatar]
  
  def index
    @users = User.order('updated_at DESC').page(params[:page]).per(21)
  end

  def show
     @user = User.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Ваша учётная запись изменена.' }
        # format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      # format.json { head :no_content }
    end
  end

  def avatar
  end

  def load_avatar
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   #User.find(params[:id])
    # end

    # Non devise paths - Edit User -> through Devise; Index, Show User - can all. Avatar -> current-user 
    def check_user
      unless User.friendly.find(params[:id]) == current_user 
        goto_root
      end
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:fname, :mname, :lname, :name, :email, :avatar, :crop_x, :crop_y, :crop_w, :crop_h)
    end


    def goto_root
      redirect_to root_path, notice: 'Вы не можете просматривать или редактировать приватные записи других членов сообщества.'
    end

end
