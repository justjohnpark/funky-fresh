module RecipeHelper

	class Hash
	  def only(*whitelist)
	    {}.tap do |h|
	      (keys & whitelist).each { |k| h[k] = self[k] }
	    end
	  end
	end
	
	class YummlyWorker

		def search_yummly_for(ingredients) 
			Yummly.search(ingredients, 'maxResult' => 5)
		end

		def sort_matches(matches)
			matches.sort{|a, b| [b['pantry_has'].length, b['rating']]<=> [a['pantry_has'].length, a['rating']]}
		end

		def get_relevant_data(matches)
			matches.each do |match, values|
				recipe = Yummly.find(match['id'])
				match['recipe'] = recipe.json.only 'attribution', 'name', 'rating'
				match['recipe']['ingredients'] = recipe.ingredients
				match['recipe']['thumbnail'] = recipe.thumbnail
			end
		end

		def best_matches(search_results, pantry)
			matches = search_results.matches.map{ |match| {'id' => match['id'], 'pantry_has' => pantry.pantry_has(match['ingredients']).join(', ') , 'pantry_might_have' => pantry.pantry_might_have(match['ingredients']).join(', '), 'pantry_missing' => pantry.pantry_missing(match['ingredients']).join(', '), 'sourceDisplayName' => match['sourceDisplayName']} }
			recipes = get_relevant_data(matches)
			sorted_matches = sort_matches(recipes)
		end
	end
end