class SupportController < ApplicationController

  def new
    @error_messages = []
  end

  def create
    from_email = params[:email]
    message = params[:message]

    @error_messages = []
    @error_messages << 'Please enter an email' if from_email.blank?
    @error_messages << 'Please enter a message' if message.blank?

    if @error_messages.empty?
      # Send message to support email
      SupportMailer.contact_support(from_email, message).deliver_now
      # Show success message
      render :success
    else
      # Show user errors
      render :new
    end


  end

end
