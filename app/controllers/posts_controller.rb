class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :output, {only: [:index, :new, :create]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: :desc)
    # @user_posts = Post.where(user_id: @current_user.id).order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end

  def new
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
    
    
  end

  def create
    # @user_posts = Post.where(user_id: @current_user.id).order(created_at: :desc)
    @post = Post.new(
      # days: params[:days],
      days: @study_days,
      hours: params[:hours],
      # t_hours: params[:t_hours],
      t_hours: @user_posts.sum(:hours) + params[:hours].to_f,
      content: params[:content],
      user_id: @current_user.id
      )
      if @post.save
        redirect_to("/posts/index")
        flash[:notice] = "投稿を作成しました"
      else
        render("posts/new")
      end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      @future_posts = Post.where(user_id: @current_user.id).where("id > #{@post.id}")
      @future_posts.each do |future_post|
        future_post.t_hours -= @post.hours
        future_post.save
      end
      flash[:notice] = "投稿ID#{@post.id}の投稿を削除しました"
      redirect_to("/posts/index")
    end
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end

