class ContactsController < ApplicationController
  before_action :authenticate_user!
  # before_action :goto_root , only: [:index, :show, :new, :create ]
  # before_action :check_user, only: [:edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update]
  # , only: :update

  filter_resource_access

  # filter_access_to :all, :attribute_check => true
  # filter_resource_access  :attribute_check => true

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
      # unless User.friendly.find(params[:user_id]) == current_user && Contact.find(User.friendly.find(params[:user_id])) == Contact.find(params[:id])
      #   goto_root
      # end
      @user = User.friendly.find(params[:user_id])
      @contact = current_user.contact
    end

    # # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:phone, :phone2, :show_skype, :skype, :show_site, :site,
       :vkontakte, :facebook, :odnoklassniki, :twitter, :linkedin)
    end

    # def goto_root
    #   redirect_to root_path, notice: 'Вы не можете просматривать или редактировать приватные записи других членов сообщества.'
    # end
end
