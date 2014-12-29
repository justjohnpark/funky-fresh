class RecipesController < ApplicationController
	include RecipeHelper
	def index
		yummly_worker = YummlyWorker.new
		@user = User.find(params[:user_id])
		@pantry = Pantry.find(params[:pantry_id])
		@items = @pantry.recipe_search_parameters
		@search_results = yummly_worker.search_yummly_for(@items)
		@best_matches = yummly_worker.best_matches(@search_results ,@pantry) unless @search_results.matches.empty?
	end
end
