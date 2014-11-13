class Pantry < ActiveRecord::Base
  has_many :pantry_participations
  
  has_many :users, through: :pantry_participations
  
  belongs_to :creator, class_name: "User"
  
  has_many :items, dependent: :destroy

  has_many :invites

  validates :creator_id, :name, presence: true

  def recipe_search_parameters
    items.order(:expiration_date).limit(3).map{ |item| item.prototype.name}.flatten.join(', ')
  end

  def pantry_item_names_and_plurals
    items.map{ |item| [item.prototype.name, item.prototype.name.pluralize] }.flatten.uniq
  end

  def comparators
    hash = {}
    array = pantry_item_names_and_plurals
    array.each{ |name| hash[name] = true }
    hash
  end

  def pantry_has(ingredients)
    pantry_items = comparators
    ingredients.select{|ingredient| pantry_items[ingredient]}
  end

  def pantry_might_have(ingredients)
    # refactor so we call the previous methods within this method and return a hash 
    item_names = pantry_item_names_and_plurals
    might_have = []
    item_names.each do |item| 
      ingredients.each do |ingredient|
        might_have << ingredient if ingredient.include?(item) || item.include?(ingredient) 
      end
    end
    might_have.uniq - pantry_has(ingredients)
  end

  def pantry_missing(ingredients)
    ingredients - (pantry_might_have(ingredients) + pantry_has(ingredients))
  end

  def search(query)
    item_names = self.items.map{ |item| item.prototype.name }
    item_names.include?(query)
  end

  def item_checker(threshold)
    # could be refactored => items.select { |item| item.funky_or_fresh?(threshold) }
    funky_items = []
    self.items.each do |item|
      if item.funky_or_fresh?(threshold)
        funky_items << item
      end
    end
    funky_items
  end
end