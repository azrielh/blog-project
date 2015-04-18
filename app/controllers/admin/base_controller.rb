class Admin::BaseController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize


  def authorize
    redirect_to root_path unless current_user.is_admin?
  end

end
