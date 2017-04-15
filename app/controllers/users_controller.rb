class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  	@sent_mails = SentMail.where(sender_address: @user.email).order('created_at DESC')
  	@received_mails = SentMail.where(recipient_address: @user.email).order('created_at DESC')
  end
end
