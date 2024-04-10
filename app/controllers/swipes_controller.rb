class SwipesController < ApplicationController
  before_action :logged_in_user, only: [:index, :matches, :likedpage]
  before_action :admin_user, only: [:likedpage]
  
    def index
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
  
      # Find match
      matched_user_ids = liked_swipes.select do |swipe|
        user.swipes.exists?(liked_user_id: swipe.user_id, liked: true)
      end.pluck(:user_id)
      
      # Group the swipes by liked_user_id and count the number of swipes for each user
      matched_user_counts = liked_swipes.group(:liked_user_id).count
      
      # Retrieve matched + count
      @indv_matches = User.where(id: matched_user_ids)
              .includes(:images)
              .map { |user| { user: user, match_count: matched_user_counts[user.id] || 0 } }
      
      # Add indv match to match array
      @matches.concat(@indv_matches)
      end
      
      # Add users no match 
        users_without_matches = User.where.not(id: @matches.map { |match| match[:user].id })
        .includes(:images)
        .map { |user| { user: user, match_count: 0 } }
      @matches.concat(users_without_matches)
      
    end
    
    def matches
      liked_swipes = current_user.swipes.where(liked: true)
      liked_swipes = liked_swipes.where(liked_user_id: User.pluck(:id)) #remove deleted users from liked swipes object
      # matched_swipes = liked_swipes.select do |swipe|
      #   current_user.swipes.exists?(liked_user_id: swipe.user_id, liked: true)
      # end
      #Rails.logger.error("Alfred")
      #Rails.logger.error(liked_swipes)
      matched_swipes = liked_swipes.select do |swipe|
        current_user.swipes.exists?(liked_user_id: swipe.user_id, liked: true) &&
          #swipe.user.swipes.exists?(liked_user_id: current_user.id, liked: true)
          swipe.liked_user.swipes.exists?(liked_user_id: current_user.id, liked: true)
      end

       @matches = matched_swipes.reject { |swipe| swipe.liked_user_id == current_user.id }.map(&:liked_user)
       @images = @matches.map(&:images)
    end  
      #@matches = matched_swipes.map(&:liked_user).compact
      #@images = @matches.map { |user| user.images if user }.compact
      
      #matched_user_counts = liked_swipes.group(:liked_user_id).count
    
    
    
    
    def like
      user = User.find(params[:id])
      current_user.swipes.create(liked_user: user, liked: true)
      
      # Check if liked user also liked current_user
      if Swipe.exists?(user_id: user.id, liked_user_id: current_user.id, liked: true)
      # Both users have liked = match
        current_user.swipes.create(user_id: user.id, liked_user_id: current_user.id, liked: true, matched: true)
        user.swipes.create(user_id: current_user.id, liked_user_id: user.id, liked: true, matched: true)
      end
    
      #redirect_to swipes_path
      render json: { message: 'success' }
    end
    
    def dislike
      user = User.find(params[:id])
      current_user.swipes.create(disliked_user: user, liked: false)
      #redirect_to swipes_path
      render json: { message: 'success' }
    end
    
    private
    
      def logged_in_user
        unless logged_in?
          store_location
          flash[:notice] = "Please log in."
          redirect_to login_path
        end
      end
      
      def admin_user
        if current_user.nil? || !current_user.admin?
          flash[:notice] = "Not Authorized."
          redirect_to swipes_path
        end
      end
end