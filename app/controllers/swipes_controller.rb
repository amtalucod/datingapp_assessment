class SwipesController < ApplicationController
    def index
      # Fetch user profiles based on gender interest
      liked_user_ids = current_user.liked_swipes.pluck(:liked_user_id)
      disliked_user_ids = current_user.disliked_swipes.pluck(:disliked_user_id)
      @users = User.where(gender: current_user.gender_interest)
                              .where.not(id: current_user.id)
                              .where.not(id: liked_user_ids)
                              .where.not(id: disliked_user_ids) 
      # Use map to iterate over each user in @users, For each user, we access their images using user.images.
      @images = @users.map(&:images)
    end
    
    def likedpage
      @users = User.all
      @matches = []
      
      @users.each do |user|
        @swipes = user.swipes.all
      liked_swipes = user.swipes.where(liked: true)
  
      # Find the user IDs of users who have swiped back
      matched_user_ids = liked_swipes.select do |swipe|
        user.swipes.exists?(liked_user_id: swipe.user_id, liked: true)
      end.pluck(:user_id)
      
      # Group the swipes by liked_user_id and count the number of swipes for each user
      matched_user_counts = liked_swipes.group(:liked_user_id).count
      
      # Retrieve the matched users along with their counts
      @indv_matches = User.where(id: matched_user_ids)
              .includes(:images)
              .map { |user| { user: user, match_count: matched_user_counts[user.id] || 0 } }
      
      #@matches.push(@indv_matches)
      @matches.concat(@indv_matches)
      end
      
    end
    
    def matches
      liked_swipes = current_user.swipes.where(liked: true)
      matched_swipes = liked_swipes.select do |swipe|
        current_user.swipes.exists?(liked_user_id: swipe.user_id, liked: true)
      end

      @matches = matched_swipes.map(&:liked_user)
      @images = @matches.map(&:images)
      
      matched_user_counts = liked_swipes.group(:liked_user_id).count
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