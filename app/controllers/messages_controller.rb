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
    
    private
    def authenticate_user!
        redirect_to login_path unless current_user
    end
    
    # def correct_recipient 
    #   @recipient = current_user.matches.find(params[:id])
    #   redirect_to root_path unless @recipient
    # end
end
  