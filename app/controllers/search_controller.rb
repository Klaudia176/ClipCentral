class SearchController < ApplicationController
    def index
        @users_search = User.ransack(params[:q])
    
        Rails.logger.debug "User Search: #{@users_search.inspect}"
      
        @standard_users = @users_search.result.where(role: 0)
        @premium_users = @users_search.result.where(role: 1)
      end

    def profiles
        @user = User.find_by(name: params[:name]) # Assuming you pass user ID in the URL
    end
  end
  