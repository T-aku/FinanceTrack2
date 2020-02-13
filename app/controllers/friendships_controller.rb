class FriendshipsController < ApplicationController
  
  def index
    @friends = current_user.friends
  end
  
  def destroy 
    friend = User.find(params[:id])
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: friend.id)
    friendship.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to friendships_path
  end
  
  def search
    if params[:email].present?
      @friend = User.find_by(email: params[:email])
      if @friend
        respond_to do |format|
          format.js { render partial: 'friendships/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid email to search"
          format.js { render partial: 'friendships/result' }
        end
       end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a email"
        format.js { render partial: 'friendships/result' }
      end
    end
  end
  
  
    
    
end