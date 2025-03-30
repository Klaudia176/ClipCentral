class VideosController < ApplicationController
  before_action :authenticate_user!

  def show
    @video = Video.find(params[:id])
    @comments = @video.comments.includes(:user)
    @comment = Comment.new
    @report = Report.new
  end

  def create
    @video = current_user.videos.build(video_params)

    if @video.save
      flash[:notice] = 'Film został pomyślnie przesłany.'
    if current_user.premium?
      redirect_to new_premium_video_path
    else
      redirect_to new_standard_video_path
    end

    else
    flash.now[:alert] = 'Wystąpił problem podczas przesyłania filmu.'
    
    if current_user.premium?
      redirect_to new_premium_video_path 
    else
      redirect_to new_standard_video_path
    end
    end
  end

  def destroy
    @video = Video.find(params[:id])
    if current_user.admin?
      if @video.destroy
        flash[:success] = 'Film został usunięty pomyślnie.'
        redirect_to rep_path
      else
        flash[:error] = 'Wystąpił błąd podczas usuwania filmu.'
        redirect_to video_path(@video)
      end
    else
      flash[:alert] = 'Nie masz uprawnień do usunięcia tego filmu.'
      redirect_to video_path(@video)
    end
  end


  def download
    @video = Video.find(params[:id])
  
    if @video.uploaded_video.attached?
      mime_type = @video.uploaded_video.content_type
  
      send_data @video.uploaded_video.download, type: mime_type, disposition: 'attachment', filename: @video.uploaded_video.filename.to_s
    else
      render plain: "Nie znaleziono pliku", status: :not_found
    end
  end
  

  private

  def video_params
    params.require(:video).permit(:title, :description, :uploaded_video)
  end
end

