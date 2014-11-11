require 'spec_helper'

describe Item do
  
  context 'schema' do 
    it { should have_db_column(:pantry_id).of_type(:integer)}
    it { should have_db_column(:prototype_id).of_type(:integer)}
    it { should have_db_column(:expiration_date).of_type(:date)}
  end

  context 'validations' do 
    it { should validate_presence_of :pantry_id}
    it { should validate_presence_of :prototype_id}
  end

  context 'associations' do 
    it { should belong_to :prototype}
    it { should belong_to :pantry}
  end

  context 'methods' do 
    before(:each) do 
      @pantry = FactoryGirl.create(:pantry)
      @proto = FactoryGirl.create(:prototype)
      @item  = FactoryGirl.create(:item, prototype_id: @proto.id, pantry_id: @pantry.id)
    end

    describe 'prototype_name' do 
      it 'should be readable' do 
        @item.prototype_name.should == @proto.name
      end
      
      it 'should be writable' do 
        @item.prototype_name = "ice cream cake"
        @item.prototype.name.should == 'ice cream cake'
      end
    end

    describe 'set_expiration_date' do 
      it "should calculate an item's expiration date from its prototype's shelf_life" do 
        @item.expiration_date.should == (Date.today + 30.days)
      end
    end

    describe 'set_prototype_shelf_life' do 
      it 'should calculate the shelf life of a custom item' do 
        FactoryGirl.reload
        ice_cream_cake = Item.create(prototype_name: 'ice cream cake', expiration_date: Date.today + 15.days, pantry_id: @pantry.id)
        ice_cream_cake.prototype.shelf_life.should == 15
      end
    end

    describe 'funky_or_fresh?' do 
      it "should return true if an item's expiration date is within the threshold" do
        @item.funky_or_fresh?(30).should == true
      end

      it "should return false if an item's expiration date is outside of the threshold" do
        @item.funky_or_fresh?(29).should == false
      end
    end
  end
end
