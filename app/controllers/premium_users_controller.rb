class PremiumUsersController < ApplicationController
    before_action :authenticate_user!
    def index
      @videos = Video.includes(:user).where(users: { role: 1 })

      @users_search = User.ransack(params[:q])
      @standard_users = @users_search.result.where(role: 0)
      @premium_users = @users_search.result.where(role: 1)
    end

    def profile
      @videos = current_user.videos.includes(:user)

      @users_search = User.ransack(params[:q])
      @standard_users = @users_search.result.where(role: 0)
      @premium_users = @users_search.result.where(role: 1)
    end

    def add
      @video = Video.new
      render 'videos/new_premium' # Explicitly state to render the videos/new view
    end

    def update
      if @user.update(user_params)
        redirect_to profile_path, notice: 'Profil został zaktualizowany.'  # Adjust redirection as needed
      else
        render :profile  # Show the profile view again if there are errors
      end
    end

    def help
      @contact = Contact.new(email: current_user.email)

      user_email = current_user.email
      @replied_contacts = Contact.where(email: user_email).where.not(reply: nil).order(updated_at: :desc) || []
      @pending_contacts = Contact.where(email: user_email).where(reply: nil).order(created_at: :asc) || []

      @users_search = User.ransack(params[:q])
      @standard_users = @users_search.result.where(role: 0)
      @premium_users = @users_search.result.where(role: 1)
    end
  
    def new
      @contact = Contact.new(contact_params)
      @contact.email = current_user.email if user_signed_in?
      if @contact.save
        flash[:alert] = 'Wiadomość została wysłana!'
        redirect_to phelp_path
      else
        Rails.logger.debug @contact.errors.full_messages
        render :help
      end
    end
    
    private
    
    def set_user
      @user = current_user  # Use current_user since it's already authenticated
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation)
    end

    def contact_params
      params.require(:contact).permit(:email, :message)
    end

end
