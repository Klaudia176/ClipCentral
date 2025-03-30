class ReportsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @video = Video.find(params[:video_id])
      @report = @video.reports.build(report_params)
      @report.user = current_user
  
      if @report.save
        flash[:notice] = 'Film został zgłoszony pomyślnie.'
        redirect_to video_path(@video) # Redirect back to the video page after reporting
      else
        flash.now[:alert] = 'Wystąpił problem podczas zgłaszania filmu.'
        redirect_to video_path(@video) # Lepsze byłoby powrócić w przypadku błędu
      end
    end

    def destroy
      @report = Report.find(params[:id]) # Znajdź zgłoszenie według ID
      @video = @report.video # Pobierz związany film
  
      if @report.destroy
        flash[:success] = 'Zgłoszenie zostało usunięte.'
      else
        flash[:error] = 'Wystąpił błąd podczas usuwania zgłoszenia.'
      end
      redirect_to video_path(@video) # Przekierowanie do strony filmu
    end
  
    private
  
    def report_params
      params.require(:report).permit(:reason) # Walidacja
    end
  end
