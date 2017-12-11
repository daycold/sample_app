class MiccommentsController < ApplicationController
  before_action :logged_in_user
  def create
    if !params[:miccomment][:micropost_id].nil?
      micropost = Micropost.find(params[:miccomment][:micropost_id])
      micropost.comment_create(params[:miccomment][:commenter_id],params[:miccomment][:content],params[:miccomment][:comment_to])
    else
      micropost = Micropost.find(params[:micropost_id])
      micropost.comment_create(params[:commenter_id],params[:content])
    end
    params_set
  end

  def destroy
    Miccomment.find(params[:id]).destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  private
  def params_set
    if request.url.include?("index")
      @users = User.paginate(page: params[:type])
    elsif request.url.include?("show")
      @user = User.find(params[:id])
    else
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    redirect_back_or(root_path)
  end
end
