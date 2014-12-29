class RecipesController < ApplicationController
	include RecipeHelper
	def index
		@user = User.find(params[:user_id])
		@pantry = Pantry.find(params[:pantry_id])
		@items = @pantry.recipe_search_parameters
		@search_results = search_yummly_for(@items)
		@best_matches = best_matches(@search_results ,@pantry) unless @search_results.matches.empty?
	end
end

class Hash
  def only(*whitelist)
    {}.tap do |h|
      (keys & whitelist).each { |k| h[k] = self[k] }
    end
  end
end