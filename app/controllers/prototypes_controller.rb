class PrototypesController < ApplicationController
  # 認証済みユーザーのみがアクセスできるアクションを指定
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  # 共通のプロトタイプ設定メソッドを実行するアクションを指定
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  # 投稿者のみが編集・更新・削除できるように権限を確認
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  def index
    @prototypes = Prototype.all
  end

  def show
    @comments = @prototype.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    # 新規プロトタイプ投稿フォームを表示するためのアクション
    #@prototype = Prototype.new
    @prototype = current_user.prototypes.build
  end

  def destroy
    @prototype.destroy
    redirect_to prototypes_path, notice: 'プロトタイプが削除されました。'
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to prototypes_path, alert: 'プロトタイプが見つかりませんでした。'
  end

  def create
    # プロトタイプを作成するためのアクション
    @prototype = current_user.prototypes.new(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: 'プロトタイプが作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # アクション内の処理は後で実装します
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: 'プロトタイプが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def authorize_user!
    unless current_user == @prototype.user
      redirect_to prototypes_path, alert: 'あなたにはこのプロトタイプを編集・削除する権限がありません。'
    end
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end
end
