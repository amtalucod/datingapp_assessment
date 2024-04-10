class MessagesController < ApplicationController
    before_action :authenticate_user! 
    #before_action :correct_recipient, only: [:show, :create]
  
    def show
      @recipient = User.find(params[:id])
      @messages = Message.where(sender: current_user, recipient: @recipient)
                         .or(Message.where(sender: @recipient, recipient: current_user))
                         .order(:created_at)
    end
  
    def create
      @recipient = User.find(params[:recipient_id])
      #@swipe = Swipe.where(user_id: current_user_id, liked_user_id: id, liked: true)
      #                   .order(:created_at)
      #add swipe in msg
      # Check if the current user is matched with the recipient
      # unless current_user.matches.include?(@recipient)
      #   flash[:error] = "You can only message users who have matched with you."
      #   redirect_back(fallback_location: root_path) and return
      # end
      
      @message = current_user.sent_messages.build(recipient: @recipient, content: params[:content], sender: current_user)
    
      if @message.save
        redirect_to messages_path(@recipient)
      else
        flash[:error] = "Failed to send message."
        @message.errors.full_messages.each do |msg|
          Rails.logger.error("Failed to save user: #{msg}")
        end
        redirect_back(fallback_location: login_path)
      end
    end
    
    def index
      @conversations = current_user.received_messages.includes(:sender).group_by(&:sender)
    end
    
    private
    def authenticate_user!
      redirect_to login_path unless current_user
      flash[:notice] = "Please log in." unless current_user
    end
    
    #  def correct_recipient 
    #    @recipient = current_user.swipes.matches.find(params[:id])
    #    redirect_to root_path unless @recipient
    #  end
    
    # def correct_recipient
    #   @recipient = Swipe.matches(current_user.id).find(params[:id])
    #   # Ensure that the recipient is not the current user
    #   # Also, check if the recipient has swiped back
    #   if @recipient && Swipe.exists?(user_id: @recipient.id, liked_user_id: current_user.id, liked: true)        # You can also add additional conditions if needed
    #   else
    #     # Redirect and show a flash message if not authorized
    #     redirect_to root_path
    #     flash[:notice] = "You are not authorized to message this user."
    #   end
    # end
end
  