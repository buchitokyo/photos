class SessionsController < ApplicationController
  
  def new
  end

  def create
    #送信されたメールアドレスをparams[:session][:email]で取得し、そのemailをfind_byメソッドでデータベースからユーザを取り出しています。

    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #ログイン成功した場合
      session[:user_id] = user.id #これはuserのidを付与しているとみられる。ユーザーのブラウザ内のcookiesに暗号化されたユーザーIDが自動で生成されます。
      redirect_to user_path(current_user.id)
    else
      #ログイン失敗した場合
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end

  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
