class MicropostsController < ApplicationController

  before_action :signed_in?, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      @feed_items = current_user.feed.paginate(page: params[:page])
      flash[:success] = "Micropost created!"
      respond_to do |format|
        format.js
      end
    else
      @feed_items = []
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    @feed_items = current_user.feed.paginate(page: params[:page])
    respond_to do |format|
      format.js
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
