class Api::V1::PeopleController < ApplicationController
  def index 
    people = Person.order('created_at DESC')
    render json: {status: 'SUCCESS', message:'Carreguei Tudo!', data: people}, status: :ok
  end

  def show 
    person = Person.find(params[:id])
    render json: {status: 'SUCCESS', message:'Só o que você pediu!', data: person}, status: :ok
  end

  def create
    person = Person.new(person_params)
    if person.save
      render json: {status: 'SUCCESS', message:'Person created', data: person}, status: :ok
    else
      render json: {status: 'ERROR', message:'Person not created', data: person.errors}, status: :unprocessable_entity
    end
  end

  def destroy 
    person = Person.find(params[:id])
    person.destroy
    render json: {status: 'SUCESS', message: 'Person Deleted', data: person}, status: :ok
  end

  def update 
    person = Person.find(params[:id])
    if person.update(person_params)
      render json: { status:'SUCCESS', message: 'Person Updated', data: person }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Person NOT Updated', data: person.errors }, status: :unprocessable_entity
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :cpf, :born_on)
  end

end
