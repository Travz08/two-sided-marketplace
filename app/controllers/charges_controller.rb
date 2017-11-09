class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  def new
  end

  def create
   @amount = (@item.price * 100).to_i

   if current_user.stripe_id == nil
   customer = StripeTool.create_customer(email: params[:stripeEmail],
   stripe_token: params[:stripeToken])

   current_user.stripe_id = customer.id
   current_user.save()


   charge = StripeTool.create_charge(customer_id: customer.id,
   amount: @amount,
   description: 'Rails Stripe customer')

   @transaction = Transaction.create(user_id: current_user.id, charge_id: charge.id, charge_id: @item.id, amount: @amount)
   @transaction.user = current_user
   @transaction.save
   email = current_user.email
   contact_name = current_user.customer.first_name
   message = @transaction.charge_id
   ContactMailer.send_contact_email(email, contact_name, message).deliver_now
  else
    charge = StripeTool.create_charge(customer_id: current_user.stripe_id,
    amount: @amount,
    description: 'Rails Stripe customer')

    @transaction = Transaction.create(user_id: current_user.id, item_id: @item.id, charge_id: charge.id, amount: @amount)
    @transaction.user = current_user
    @transaction.save
    email = current_user.email
    contact_name = current_user.customer.first_name
    message = @transaction.charge_id
    ContactMailer.send_contact_email(email, contact_name, message).deliver_now
  end
 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
 end

 private

 def set_item
   @item = Item.find(params[:item_id])
 end

 def set_transaction
   @transaction = Transaction.find(params[:id])
 end
end
