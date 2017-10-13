class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
    #@listing = Listing.find(params[:listing_id])
  end

  def create
    
    #@listing = Listing.find(params[:listing_id])

    if params[:sender_id]!=params[:recipient_id] # Sender and Receiver should not be the same
      
      if Conversation.between(params[:sender_id],params[:recipient_id], params[:listing_id]).present?
        @conversation = Conversation.between(params[:sender_id], params[:recipient_id], params[:listing_id]).first
      else
        @conversation = Conversation.create!(conversation_params)
      end

      redirect_to conversation_messages_path(@conversation)

    else
      respond_to do |format|
        format.html { redirect_to listing_path(@listing), notice: 'You cannot send a message to yourself.' }
        format.json { head :no_content }
      end

    end
  end

  private
  def conversation_params
    params.permit(:listing_id, :sender_id, :recipient_id)
  end
  
end
