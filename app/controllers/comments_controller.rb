class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @prototype = Prototype.find(params[:prototype_id])
    #@comment = @prototype.comments.build(comment_params)
    #@comment.user = current_user
    @comment = @prototype.comments.build(comment_params.merge(user_id: current_user.id, prototype_id: @prototype.id))

    if @comment.save
      redirect_to prototype_path(@prototype), notice: "コメントが投稿されました。"
    else
      @comments = @prototype.comments.includes(:user)
      #redirect_to prototype_path(@prototype), alert: "コメントの投稿に失敗しました。"
      #render "prototypes/show", status: :unprocessable_entit
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
