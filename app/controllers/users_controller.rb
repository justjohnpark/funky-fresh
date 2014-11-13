class UsersController < ApplicationController
before_action :show_door, except: [:login_form, :login, :new, :create]

	def show
    @token = params[:invite_token]
    redirect_to user_path(current_user) unless current_user.id.to_s == params[:id]
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def new
    puts params
    @token = params[:invite_token]
    redirect_to user_path(current_user) if current_user
    @user = User.new
  end

  def edit
    redirect_to user_path(current_user) unless current_user.id.to_s == params[:id]
  end

  def create
      @user = User.new(user_params)
      @token = params[:invite_token]
      puts @token
      if @user.save
        if @token != nil
        pantry_id = Invite.find_by_token(@token).pantry_id
        pantry = Pantry.find_by_id(pantry_id)
        @user.pantries.push(pantry)
        end
        UserMailer.welcome_email(@user).deliver
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        respond_to do |format|
          format.html {render 'new'}
          format.js {render 'new'}
        end
      end
  end

  def update
    if params[:commit] == "Update"
      if @user.update_attributes(user_params)
      redirect_to user_path
      else
      render 'edit'
      end
    end

    if params[:commit] == "Delete"
      @user.destroy
      session.clear
      redirect_to root_path
    end
  end

  # def destroy
  #   @user.destroy
  #   session.clear
  #   redirect_to root_path#might need to change the path
  # end

  def login_form
      respond_to do |format|
        format.html {render 'login_form'}
        format.js {render 'login_form'}
      end
  end

  def login
    @user = User.find_by_email(params[:email])
      if @user
        if @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          flash[:error] = "Incorrect password"
          respond_to do |format|
            format.html {render 'login_form'}
          end
        end
      else
        flash[:notice]
        redirect_to new_user_path
      end
  end

  def logout
    session.clear
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
