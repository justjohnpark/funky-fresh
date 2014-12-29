
module RecipeHelper
	class Hash
	  def only(*whitelist)
	    {}.tap do |h|
	      (keys & whitelist).each { |k| h[k] = self[k] }
	    end
	  end
	end

	def search_yummly_for(ingredients) 
		Yummly.search(ingredients, 'maxResult' => 5)
	end

	def sort_matches(matches)
		matches.sort{|a, b| [b['pantry_has'].length, b['rating']]<=> [a['pantry_has'].length, a['rating']]}
	end

	def get_relevant_data(matches)
		matches.each do |match, values|
			recipe = Yummly.find(match['id'])
			match['recipe'] = recipe.json.only 'attribution', 'name', 'rating', 'ingredients'
			match['recipe']['thumbnail'] = recipe.thumbnail
			raise
		end
		matches.each { |match| match.to_json }
	end

	def best_matches(search_results, pantry)
		matches = [{"id"=>"Homemade-Ranch-Dressing-511618", "ingredients"=>"greek yogurt, mayonnaise, cultured buttermilk, sour cream, garlic powder, onion powder, ground black pepper, kosher salt, white vinegar, lemon juice, fresh parsley", "pantry_has"=>"", "pantry_might_have"=>"cultured buttermilk, sour cream, greek yogurt", "pantry_missing"=>"mayonnaise, garlic powder, onion powder, ground black pepper, kosher salt, white vinegar, lemon juice, fresh parsley", "sourceDisplayName"=>"Food Republic", "recipe"=>{"name"=>"Homemade Ranch Dressing", "attribution"=>{"html"=>"<a href='http://www.yummly.com/recipe/Homemade-Ranch-Dressing-511618'>Homemade Ranch Dressing recipe</a> information powered by <img alt='Yummly' src='http://static.yummly.com/api-logo.png'/>", "url"=>"http://www.yummly.com/recipe/Homemade-Ranch-Dressing-511618", "text"=>"Homemade Ranch Dressing recipes: information powered by Yummly", "logo"=>"http://static.yummly.com/api-logo.png"}, "rating"=>5, "thumbnail"=>"http://lh3.ggpht.com/0_rP0QFBS7PVIlGJPMK8LOiRePO7JzE6Hty6qBZvIU-tf8FKQS1DJ35Mak2bhZB6_1UOZKUSNE7x0K5JS0gz6YA=s90"}}]	# matches = search_results.matches.map{|match| {'id' => match['id'], 'ingredients' => match['ingredients'].join(', '), 'pantry_has' => pantry.pantry_has(match['ingredients']).join(', ') , 'pantry_might_have' => pantry.pantry_might_have(match['ingredients']).join(', '), 'pantry_missing' => pantry.pantry_missing(match['ingredients']).join(', '), 'sourceDisplayName' => match['sourceDisplayName']}}
		recipes = get_relevant_data(matches)
		sorted_matches = sort_matches(recipes)
	end

end