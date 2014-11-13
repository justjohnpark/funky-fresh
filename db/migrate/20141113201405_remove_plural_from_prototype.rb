class RemovePluralFromPrototype < ActiveRecord::Migration
  def change
    remove_column :prototypes, :plural, :string
  end
end
