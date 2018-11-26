class CommentsController < ApplicationController

    # コメントを保存、投稿するためのアクションです。
   def create
     # Pictureをパラメータの値から探し出し,Pictureに紐づくcommentsとしてbuildします。
      @picture = Picture.find(params[:picture_id])
      @comment = @picture.comments.build(comment_params)
  # クライアント(ブラウザの)要求に応じてフォーマットを変更
  respond_to do |format|
    if @comment.save
      # formatでindex.js.erbを呼び込む
      format.js { render :index }
    else
      format.html { redirect_to picture_path(@picture), notice: '投稿できませんでした...' }
    end
  end
end

private
# ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:picture_id, :content)
    end
end
