class RegistrationsController < Devise::RegistrationsController
  def new
    flash[:info] = 'В данный момент регистрация возможна только через администратора'
    redirect_to root_path
  end

  def create
    flash[:info] = 'В данный момент регистрация возможна только через администратора'
    redirect_to root_path
  end
end