class PagesController < ApplicationController
  before_action :authenticate_user!, only: :greetings

  def faq
  end

  def greetings
  end

  def goodbye
  end
  
  def help
  end
  
  def terms
  end

end
