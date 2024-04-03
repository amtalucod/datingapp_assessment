class MessagesController < ApplicationController
    before_action :authenticate_user! # Ensure user is authenticated
    
    def index
      @contacts = current_user.contacts # Retrieve contacts
    end
  
    def show
      @recipient = User.find(params[:id])
      @messages = Message.where(sender: current_user, recipient: @recipient)
                         .or(Message.where(sender: @recipient, recipient: current_user))
                         .order(:created_at)
    end
  
    def create
      @recipient = User.find(params[:recipient_id])
      @message = current_user.sent_messages.build(recipient: @recipient, content: params[:content])
      if @message.save
        redirect_to message_path(@recipient)
      else
        flash[:error] = "Failed to send message."
        redirect_back(fallback_location: root_path)
      end
    end
    
    private
    def authenticate_user!
        redirect_to login_path unless current_user
    end
end
  