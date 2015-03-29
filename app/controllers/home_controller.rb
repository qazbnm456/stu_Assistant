class HomeController < ApplicationController

  before_action :authenticate_user!, only: :index

  def index
    @user = current_user
    @micropost = @user.microposts.build if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page])
    @new_layout = true
  end

  def help
  end

  def about
  end

  def mycourse
    @data = File.read(Rails.root.join('app', 'assets', 'json', 'data.json'))
    @data_hash = JSON.parse(@data)
  end

end
