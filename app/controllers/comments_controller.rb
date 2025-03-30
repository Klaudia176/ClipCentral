class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @video = Video.find(params[:video_id])
      @comment = @video.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        flash[:notice] = 'Twój komentarz został dodany.'
        redirect_to video_path(@video)
      else
        flash[:alert] = 'Nie udało się dodać komentarza.'
        redirect_to video_path(@video)
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
        flash[:success] = 'Komentarz został usunięty.'
        redirect_to request.referrer # Powrót na stronę referencyjną
      else
        flash[:error] = 'Wystąpił błąd podczas usuwania komentarza.'
        redirect_to request.referrer # Powrót na stronę referencyjną
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  