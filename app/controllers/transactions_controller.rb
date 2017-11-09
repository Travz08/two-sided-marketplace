class TransactionsController < ApplicationController
  before_action :set_transaction

  def show

    puts @transaction

      # puts transaction
    @items = Item.find_by(params[@transaction.item_id])
  end


  private
  def set_transaction
    @transaction = Transaction.where(params[:user_id])
  end
end
