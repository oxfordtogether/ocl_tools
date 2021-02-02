class PeopleController < ApplicationController
  def new
    @person = Person.new

    render "components/form"
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to "components/form", notice: "Person was successfully created."
    else
      render "components/form"
    end
  end

  private

  def person_params
    params.require(:person).permit(:name, :date_of_birth, :start_date, :category, :file)
  end
end
