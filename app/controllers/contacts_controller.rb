class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :goto_root , only: [:index, :show, :new, :create ]
  before_action :check_user, only: [:edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to @user, notice: 'Ваша учётная запись изменена.'
    else
      render :edit
    end
  end

  private

    def check_user
      unless User.friendly.find(params[:user_id]) == current_user || Contact.find(params[:_id]) == current_user.contact.id 
        goto_root
      end
      @user = current_user
      @contact = @user.contact
    end

    # # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:phone, :phone2, :show_skype,
        :skype, :site, :vk_url, :facebook_url, :odnoklassniki_url, :twitter_url, :linkedin_url)
    end

    def goto_root
      redirect_to root_path, notice: 'Вы не можете просматривать или редактировать приватные записи других членов сообщества.'
    end
end
