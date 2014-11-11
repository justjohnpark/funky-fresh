require 'date'

class Item < ActiveRecord::Base
  belongs_to :prototype
  belongs_to :pantry

  validates :pantry_id, :prototype_id, presence: true

  before_create :set_expiration_date, if: -> { self.expiration_date.blank? && self.prototype.shelf_life.blank? == false }
  after_create :set_prototype_shelf_life, if: -> { self.prototype.shelf_life.blank? }
  before_update :set_expiration_date, if: -> { self.expiration_date.blank? }


  def prototype_name=(prototype_name)
    self.prototype = Prototype.find_or_create_by(name: prototype_name.downcase)
    self.prototype.plural = prototype_name.pluralize if self.prototype.plural.blank?
  end

  def prototype_name
    self.prototype.name if self.prototype
  end

  def set_expiration_date
      self.expiration_date = Date.today + (self.prototype.shelf_life).days
  end

  def set_prototype_shelf_life
    self.prototype.update_attributes( shelf_life: self.expiration_date - Date.today )
  end

  def funky_or_fresh?(threshold)
    min = Date.today
    max = min + threshold.days 
    self.expiration_date.between?(min, max)
  end
end
