class PantriesController < ApplicationController
	before_action :show_door
	autocomplete :prototype, :name, full: true

	def index
		@pantry = Pantry.find(params[:pantry_id])
		@query = params[:query]
		@items = @pantry.items

		if @pantry.search(@query)
			flash[:notice] = "Eureka! You have #{@query}!"
		else
			flash[:notice] = "No #{@query} here. Better put it on the list."
		end

		respond_to do |format|
			format.js do
				render 'index'
			end
			format.any do
				redirect_to user_path(current_user)
			end
		end
	end

	def new
		redirect_to user_path(current_user) unless current_user.id.to_s == params[:user_id]
		@pantry = Pantry.new
	end

	def create
		@pantry = Pantry.create(pantry_params)
		@user = current_user

		respond_to do |format|
			format.html {redirect_to user_path(@user)}
			format.json {render json: {:pantry => @pantry}}
			format.js { render "create", :locals => {:pantry => @pantry} }
		end
	end

	def show
		redirect_to user_path(current_user) unless current_user.pantries.ids.include?(params[:id].to_i)
		@pantry = Pantry.find(params[:id])
	end

	def edit
		@user = current_user
		redirect_to user_path(current_user) unless current_user.id == Pantry.find(params[:id]).creator_id
		@pantry = Pantry.find(params[:id])
		# you have to update the pantry here
		respond_to do |format|
			format.js do
				render nothing: true
			end
			format.any do
				redirect_to user_path(@user)
			end
		end
	end

	def update
		if params[:commit] == "Update"
			@user = current_user
			@pantry = Pantry.find(params[:id])
			@pantry.update(pantry_params)
			respond_to do |format|
				format.html {redirect_to user_path(@user)}
				format.json {render json: {:pantry => @pantry}}
				format.js {render "update", :locals => {:pantry => @pantry}}
			end
		end
		if params[:commit] == "Delete"
			@user = current_user
			@pantry = Pantry.find(params[:id])
			@pantry.destroy
			respond_to do |format|
				format.js do
					render nothing: true
				end
				format.any do
					redirect_to user_path(@user)
				end
			end
		end
	end

	def destroy
		# @user = current_user
		# @pantry = Pantry.find(params[:id])
		# @pantry.destroy
		# respond_to do |format|
  #     format.js do
  #       render nothing: true
  #     end
  #     format.any do
  #       redirect_to user_path(@user)
  #     end
  #   end
end

def opt_out
	@user = User.find(params[:user_id])
	@pantry = Pantry.find(params[:id])
	@pantryparticipation = PantryParticipation.find_by(user_id: @user.id, pantry_id: @pantry.id)
	@pantryparticipation.destroy
	respond_to do |format|
		format.js do
			render nothing: true
		end
		format.any do
			redirect_to user_path(@user)
		end
	end
end

private

def pantry_params
	params.require(:pantry).permit(:name, :creator_id)
end
end
