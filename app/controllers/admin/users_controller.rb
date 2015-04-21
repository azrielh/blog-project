class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def update
    @user = User.find params[:id]
    if @user.update user_params
      redirect_to admin_users_path, notice: "User update successful!"
    else
      redirect_to admin_users_path, alert: "User can't be updated..."
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to admin_users_path, notice: "User Deleted!"
  end

  private

  def user_params
    params.require(:user).permit(:is_admin)
  end

end
