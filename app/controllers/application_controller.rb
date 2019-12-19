class ApplicationController < ActionController::Base
  before_action :set_current_user


  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts/new")
    end
  end

  def output
    @user_posts = Post.where(user_id: @current_user.id).order(created_at: :desc)
    @study_days = 1
    @study_h = @user_posts.sum(:hours)
    @commit_days = @study_h_ave = @commit_rate = 0
    if @study_h > 0
      @study_days = (Date.today.strftime("%-d").to_i - @user_posts[@user_posts.length - 1].created_at.strftime("%-d").to_i) + 1
      @commit_days = (@user_posts.map {|hash| hash["created_at"].strftime("%d")}).uniq.length
      @study_h_ave = (@study_h / @study_days).round(1)
      @commit_rate = (@commit_days.to_f / @study_days.to_f * 100).round(1)
    end
  end


end
