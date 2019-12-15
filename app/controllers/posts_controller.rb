class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new

  end

  def create
    @post = Post.new(
      days: params[:days],
      hours: params[:hours],
      # t_hours: params[:t_hours],
      t_hours: Post.all.sum(:hours) + params[:hours].to_f,
      content: params[:content]
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
    flash[:notice] = "投稿ID#{@post.id}の投稿を削除しました"
    redirect_to("/posts/index")
    end
  end


end

