require 'spec_helper'

describe Pantry do

  context 'schema' do 
    it { should have_db_column :name }
    it { should have_db_column :creator_id }
  end
  
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :creator_id }
  end

  context 'associations' do
    it { should have_many(:pantry_participations) }
    it { should have_many(:users) }
    it { should belong_to(:creator) }
    it { should have_many(:items) }
  end

  context 'methods' do 
    
    before(:each) do     
        @pantry = FactoryGirl.create(:pantry)
        @proto1 = FactoryGirl.create(:prototype) 
        @proto2 = FactoryGirl.create(:prototype, name: "milk", shelf_life: 7) 
        @proto3 = FactoryGirl.create(:prototype, name: "sugar", shelf_life: 547) 
        @proto4 = FactoryGirl.create(:prototype, name: "kidney", shelf_life: 3) 
        @item1  = FactoryGirl.create(:item, prototype_id: @proto1.id, pantry_id: @pantry.id)
        @item2  = FactoryGirl.create(:item, prototype_id: @proto2.id, pantry_id: @pantry.id)
        @item3  = FactoryGirl.create(:item, prototype_id: @proto3.id, pantry_id: @pantry.id)
        @item4  = FactoryGirl.create(:item, prototype_id: @proto4.id, pantry_id: @pantry.id)
    end

    describe 'recipe_search_parameters' do 
      it "should return a string containing the names of a pantry's top (1..3) item(s) that is/are about expire " do 
        @pantry.recipe_search_parameters.should ==  "kidney, milk, apple"
      end
    end

    describe 'pantry_item_names_and_plurals' do 
      it "should return an array containing the names and plurals of a pantry's items" do 
        @pantry.pantry_item_names_and_plurals.should ==  ["apple", "apples", "milk", "sugar", "kidney", "kidneys"]
      end
    end
    
    describe 'comparators' do 
      it "should return a hash with pantry item names and plurals as the keys and 'true' as their values" do 
        @pantry.comparators.should == {"apple"=>true, "apples"=>true, "milk"=>true, "sugar"=>true, "kidney"=>true, "kidneys"=>true}
      end
    end

    describe 'pantry_has' do 
      it 'should do return what the pantry has from the ingredients passed to the method' do
        @pantry.pantry_has(['jasmine rice','milk', 'kidneys']).should == ['milk', 'kidneys']
      end
    end

    describe 'pantry_might_have' do 
      it 'should return the ingredients that the pantry might have ( e.g ingredient = jasmine rice, pantry_item = rice).' do 
        @pantry.pantry_might_have(['applesauce', 'condensed milk', 'kidneys']).should == ['applesauce','condensed milk']
      end
    end

    describe 'search' do 
      it 'should return true if the searched item is in the pantry and false otherwise' do
        @pantry.search("apple").should == true
        @pantry.search("chicken").should == false
      end
    end

    describe 'item_checker' do 
      it 'should return an array of items that have expired' do 
        @pantry.item_checker(4).should == [@item4]
      end
    end
  end

end
