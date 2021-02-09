class AddActiveFlag < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :active, :boolean
  end
end
