class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new,:index,:edit,:show,:destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    @comments = @picture.comments
    @comment = @picture.comments.build
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id #現在ログインしているuserのidをblog.user_idに代入し、blogのuser_idカラムに挿入
    #user_idはすでに、テーブルが関連づけられているだけでは、使用できない。アソシエーションをかけ、t.referencesを使用して、外部キーの
    #カラムをpicturesに作成する。また、その際,外部キーを使用する際、picturessは belongs_to :user　になる
      if @picture.save

        #ContactMailer.contact_mail(@picture).deliver
         redirect_to pictures_path, notice: 'Picture was successfully created.'
      else
        render 'new'
      end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
      if @picture.update(picture_params)
        redirect_to pictures_path, notice: 'Picture was successfully updated.'
      else
        render 'edit'
      end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: 'Picture was successfully destroyed.'
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    #禁止だっら、trueを返し、newにrender
    render :new if @picture.invalid?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:content, :image, :image_cache)
    end
    def logged_in_user
      unless current_user #ログイン中のuserでない場合は、ログイン画面へリダイレクト
        render new_session_path
      end
    end

end
