class UserMailer < ActionMailer::Base
  include RecipeHelper

  default from: "Funky||Fresh <no-reply@funky||fresh.com>"

  def welcome_email(user)
  @user = user
  # need a default @url, e.g. 'http://refrigeratory.herokuapp.com'
  mail(to: @user.email, subject: 'Welcome to Funky||Fresh!')
  end


  def expiration_alert_email(user)
    @user_pantries = {}
    @user = user
    pantries = @user.all_pantries
    
    pantries.each do |pantry|
      @user_pantries[pantry.name] = {"items" => pantry.item_checker(5)} if pantry.item_checker(5).length != 0
    end

    @user_pantries.each do |pantry_name, value|
        
      pantries.each do |pantry|
        if pantry.name == pantry_name
          ingredients = value['items'].map{|item| item.prototype.name}.join(', ')
          search_results = search_yummly_for(ingredients)
          value['matches'] = best_matches(search_results, pantry)
        end
      end
    end
    
    if @user_pantries.length != 0
      mail(to: @user.email, subject: "Food expiration alert from your friends at Funky||Fresh")
    end
  end

  def password_reset(user)  
    @user = user  
    mail :to => @user.email, :subject => "Password Reset"  
  end  
end
