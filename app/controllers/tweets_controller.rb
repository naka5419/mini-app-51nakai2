class TweetsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    
  end

  def new
  end

  def create
    
    #Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
    # Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)

    # Tweet.create(tweet_params)
    tweet = Tweet.new(tweet_params)
    tweet.save!

    redirect_to root_path
    
  end


  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update!(tweet_params)
    end
  end

  def show

    @tweet = Tweet.find(params[:id])
    # @comments = @tweet.comments.includes(:user)
  
    # @comments = @tweet.comments.includes(:user)    
  end

  private
  def tweet_params
    
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
    # params.require(:tweet).permit(:image, :text, :user_id)
    # params.require(:review).permit(:nickname, :rate, :review).merge(product_id: params[:product_id])
    # params.permit(:image, :text) 
    
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
