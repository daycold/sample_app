class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @miccomment = Miccomment.new
      if like_session?
        micropost = Micropost.find_by(id: params[:micropost])
        Micropost.dolike(current_user,micropost)
        session[:like_flag] = 'f'
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
