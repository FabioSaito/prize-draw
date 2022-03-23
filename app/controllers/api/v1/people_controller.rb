class Api::V1::PeopleController < ApplicationController
  def index 
    people = Person.order('created_at DESC')
    render json: {status: 'SUCCESS', data: people}, status: :ok
  end

  def show 
    person = Person.find(params[:id])
    render json: {status: 'SUCCESS', data: person}, status: :ok
  end

  def create
    person = Person.new(person_params)
    if person.save
      render json: {status: 'SUCCESS', data: person}, status: :ok
    else
      render json: {status: 'ERROR', data: person.errors}, status: :unprocessable_entity
    end
  end

  def destroy 
    person = Person.find(params[:id])
    person.destroy
    render json: {status: 'SUCESS', data: person}, status: :ok
  end

  def update 
    person = Person.find(params[:id])
    if person.update(person_params)
      render json: { status:'SUCCESS', data: person }, status: :ok
    else
      render json: { status: 'ERROR', data: person.errors }, status: :unprocessable_entity
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :cpf, :born_on)
  end

end
