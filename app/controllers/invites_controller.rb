class InvitesController < ApplicationController
  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.create!(invite_params)
    set_sender_id(@invite)
    @invite.sort_n_send
    respond_to do |format|
      format.html {redirect_to user_path(@user)}
      format.json {render json: {:pantry => @pantry}}
      format.js { render nothing: true   }
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :pantry_id, :sender_id)
  end

  def set_sender_id(invite)
    user = current_user
    invite.sender_id = user.id
  end

end

