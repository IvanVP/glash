class PagesController < ApplicationController
  before_action :authenticate_user!, only: :greetings

  def default
    redirect_to ideas_path if signed_in?
  end

  def faq
  end

  def greetings
  end

  def goodbye
  end
  
  def help
  end

  def privacy_policy
  end
  
  def terms
  end

end
