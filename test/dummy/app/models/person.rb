class Person < ApplicationRecord
  validates :name, :date_of_birth, :start_date, :category, :file, presence: { message: "This field is required" }
end
