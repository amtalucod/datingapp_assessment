class SwipesController < ApplicationController
    def index
      # Fetch user profiles based on gender interest
      #@users = User.where(gender: current_user.gender_interest).where.not(id: current_user.id)
      liked_user_ids = current_user.liked_swipes.pluck(:liked_user_id)
      disliked_user_ids = current_user.disliked_swipes.pluck(:disliked_user_id)
      @users = User.where(gender: current_user.gender_interest)
                              .where.not(id: current_user.id)
                              .where.not(id: liked_user_ids)
                              .where.not(id: disliked_user_ids)               
    end
    
    def likedpage
      @swipes = current_user.swipes.all
    end
    
    def matches
      liked_swipes = current_user.swipes.where(liked: true)
      matched_swipes = liked_swipes.select do |swipe|
        current_user.swipes.exists?(liked_user_id: swipe.user_id, liked: true)
    end

      @matches = matched_swipes.map(&:liked_user)
    end
    
    def like
      user = User.find(params[:id])
      current_user.swipes.create(liked_user: user, liked: true)
      
      # Check if the liked user has also liked the current user
      if Swipe.exists?(user_id: user.id, liked_user_id: current_user.id, liked: true)
        # Both users have liked each other, so it's a match
        current_user.swipes.create(user_id: user.id, liked_user_id: current_user.id, liked: true, matched: true)
        user.swipes.create(user_id: current_user.id, liked_user_id: user.id, liked: true, matched: true)
      end
    
      redirect_to swipes_path
    end
    
    def dislike
      user = User.find(params[:id])
      current_user.swipes.create(disliked_user: user, liked: false)
      redirect_to swipes_path
    end
    
  
end