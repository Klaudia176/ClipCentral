class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin
  
    def index 
      @users_search = User.ransack(params[:q])
      @standard_users = @users_search.result.where(role: 0)
      @premium_users = @users_search.result.where(role: 1)
    end

    def users 
      @users = User.all

      @users_search = User.ransack(params[:q])
      @standard_users = @users_search.result.where(role: 0)
      @premium_users = @users_search.result.where(role: 1)
    end

    def help 
      @contacts = Contact.all

      @users_search = User.ransack(params[:q])
      @standard_users = @users_search.result.where(role: 0)
      @premium_users = @users_search.result.where(role: 1)
    end

    def all
      @videos = Video.includes(:user).all  # Pobierz wszystkie filmy z informacji o użytkownikach
      @comments = Comment.includes(:user).all

      @users_search = User.ransack(params[:q])
      @standard_users = @users_search.result.where(role: 0)
      @premium_users = @users_search.result.where(role: 1)
    end

    def settings
      @users_search = User.ransack(params[:q])
      @standard_users = @users_search.result.where(role: 0)
      @premium_users = @users_search.result.where(role: 1)
    end
    
    def reports
      @videos = Video.includes(:user).all
      @reports = Report.includes(:user, :video).all # Pobierz wszystkie zgłoszenia

      @users_search = User.ransack(params[:q])
      @standard_users = @users_search.result.where(role: 0)
      @premium_users = @users_search.result.where(role: 1)
    end

    def destroy # usuwanie użytkowników
      @user = User.find(params[:id])
      if @user.destroy
        flash[:success] = 'Użytkownik został usunięty.'
      else
        flash[:error] = 'Wystąpił błąd podczas usuwania użytkownika.'
      end
      redirect_to usr_path
    end

    #KONFIGURACJA STRONY - ADMIN - ZMIANA WYGLĄDU NA JASNY I CIEMNY

    def moon 
      cookies[:moon] = {
        value: 'dark mode on'
      }
      if @logged_in_user
        redirect_to set_path,  notice: 'Ustawienia zostały zaktualizowane.'
      else
        redirect_to set_path, notice: 'Ustawienia zostały zaktualizowane.'
      end
    end
  
    def sun 
      cookies.delete(:moon)
      if @logged_in_user
        redirect_to set_path, notice: 'Ustawienia zostały zaktualizowane.'
      else
        redirect_to set_path, notice: 'Ustawienia zostały zaktualizowane.'
      end
    end  

  private
  
    def authorize_admin
      redirect_to(root_path, alert: 'You are not authorized to access this page.') unless current_user.admin?
    end
end
