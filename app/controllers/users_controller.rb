class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:type])
    if like_session?
      like
      session[:like_flag] = 'f'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @miccomment = Miccomment.new
    if like_session?
      like
      session[:like_flag] = 'f'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title  = "Following"
    @user   = User.find(params[:id])
    @users  = @user.following.paginate(page: params[:page])
    render    'show_follow'
  end

  def followers
    @title  = "Followers"
    @user   = User.find(params[:id])
    @users  = @user.followers.paginate(page: params[:page])
    render    'show_follow'
  end

  def try
    @micropost = Micropost.find(241)
  end

  private
  def user_params
    params.require(:user).permit(:name, :sex, :email,:local, :password, :password_confirmation)
  end

  def like
    micropost = Micropost.find_by(id: params[:micropost])
    Micropost.dolike(current_user,micropost)
  end

  def comment
      micropost=Micropost.find_by(id: session[:micropost])
      micropost.comment_create(current_user,session[:comment])
  end

end
