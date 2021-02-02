class PersonModel < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.timestamps

      t.string :name, null: false
      t.date :date_of_birth, null: true
      t.date :start_date, null: true
      t.string :category, null: true
      t.string :file, null: true
    end
  end
end
