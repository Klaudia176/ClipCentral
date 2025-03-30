class UsersController < ApplicationController
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to @user, notice: "Profil został zaktualizowany."
      else
        render :edit
      end
    end

    def profile
      @user = User.find_by(id: params[:id])
      render :user_profile
    end 
  
    private
  
    def user_params
      params.require(:user).permit(:avatar, :name, :email) # inne atrybuty, które chcesz zaktualizować
    end
  end
  