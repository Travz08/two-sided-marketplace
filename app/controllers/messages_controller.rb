class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    puts "---- #{@conversation.inspect}"
    @message = @conversation.messages.create(message_params)
    puts "--#{@message.errors.inspect}"

      # @messages={:owner=>["must exist"],
      # :customer=>["must exist"]}, @details={:owner=>[{:error=>:blank}],
      # :customer=>[{:error=>:blank}]}>

    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end
