class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :goto_root , only: [:new, :create, :edit, :destroy]
  # before_action :set_user, only: [ :update, :avatar, :load_avatar]
  
  filter_access_to :avatar, :load_avatar, :attribute_check => true
  filter_resource_access

  def index
    @users = User.order('updated_at DESC').page(params[:page]).per(21)
  end

  def show
    @user = User.includes(:ideas).friendly.find(params[:id])

    # !!!! Убратьь потом -- order('id ASC')
    @ideas = @user.ideas.order('id ASC').includes(:assets, :votes_for)
    @draft_ideas = @ideas.drafted
    @moderating_ideas = @ideas.published
    @active_ideas = @ideas.moderated
    @archieved_ideas = @ideas.archieved

  end

  def edit
  end
  def new
  end
  def create
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

  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url }
  #     # format.json { head :no_content }
  #   end
  # end

  def avatar
  end

  def load_avatar
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:fname, :mname, :lname, :name, :email, :avatar, :crop_x, :crop_y, :crop_w, :crop_h)
    end



    
    # # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   # @user ||= User.find(params[:id])
    #   # @user = current_user
    # end

    # Non devise paths - Edit User -> through Devise; Index, Show User - can all. Avatar -> current-user 
    # def check_user
    #   unless User.friendly.find(params[:id]) == current_user 
    #     goto_root
    #   end
    #   @user = current_user
    # end


    # def goto_root
    #   redirect_to root_path, notice: 'Вы не можете просматривать или редактировать приватные записи других членов сообщества.'
    # end

end
